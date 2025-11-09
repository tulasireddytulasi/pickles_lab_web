import 'package:flutter/material.dart';
import 'package:pickles_lab_dashboard/app/core/constants/app_keys.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_colors.dart';

/// The fixed top header bar. Includes search, notifications, and user profile.
///
/// This is a [StatefulWidget] primarily because of the search input field
/// which needs to manage its focus and text state internally.
class TopNavigationBar extends StatefulWidget implements PreferredSizeWidget {
  final bool isMobile;
  const TopNavigationBar({super.key, this.isMobile = false});

  @override
  State<TopNavigationBar> createState() => _TopNavigationBarState();

  @override
  Size get preferredSize => const Size.fromHeight(64.0);
}

class _TopNavigationBarState extends State<TopNavigationBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Adjust padding and elements based on mobile/desktop context
    final horizontalPadding = widget.isMobile ? 16.0 : 24.0;

    // For mobile, the AppBar already handles the background/border,
    // but for desktop, we must explicitly set it.
    final desktopDecoration = BoxDecoration(
      color: AppColors.cardBackground, // bg-white
      border: const Border(bottom: BorderSide(color: AppColors.border)),
    );

    return Container(
      height: widget.preferredSize.height,
      decoration: widget.isMobile ? null : desktopDecoration,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Section (Search on Desktop, Logo/Title on Mobile)
          _buildSearchField(theme),

          // Right Section (Icons and User Profile)
          Row(
            children: [
              // Notification Icon
              _buildIconButton(
                key: AppKeys.topNavNotificationsButton,
                icon: Icons.notifications_none,
                tooltip: 'Notifications',
                onTap: () => _showSnackbar(context, 'Notifications tapped'),
              ),

              // Settings Icon (Added for common dashboard functionality)
              _buildIconButton(
                key: AppKeys.topNavSettingsButton,
                icon: Icons.settings_outlined,
                tooltip: 'Settings',
                onTap: () => _showSnackbar(context, 'Settings tapped'),
              ),

              const SizedBox(width: 16),

              // User Avatar and Name
              _buildUserProfile(theme),
            ],
          ),
        ],
      ),
    );
  }

  // Helper to build the search field
  Widget _buildSearchField(ThemeData theme) {
    // On Mobile, show the title/logo instead of the full search bar
    if (widget.isMobile) {
      return Text(
          'Pickles Admin',
          style: theme.textTheme.titleLarge!.copyWith(color: AppColors.textDark)
      );
    }

    return Expanded(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300), // Max width for search box on desktop
        child: Semantics(
          label: 'Search dashboard content',
          textField: true,
          child: TextField(
            key: AppKeys.topNavSearchField,
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: const Icon(Icons.search, color: AppColors.textMedium, size: 20),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                icon: const Icon(Icons.clear, color: AppColors.textMedium),
                onPressed: () => setState(() => _searchController.clear()),
                tooltip: 'Clear search',
              )
                  : null,
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            ),
            onChanged: (value) => setState(() {}), // Trigger rebuild to show/hide clear button
            onSubmitted: (value) => _showSnackbar(context, 'Search for: $value'),
          ),
        ),
      ),
    );
  }

  // Helper to build a clickable icon button
  Widget _buildIconButton({
    Key? key,
    required IconData icon,
    required String tooltip,
    VoidCallback? onTap
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Semantics(
        button: true,
        label: tooltip,
        child: Tooltip(
          message: tooltip,
          child: InkWell(
            key: key,
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: AppColors.textMedium,
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper to build the user profile avatar/name
  Widget _buildUserProfile(ThemeData theme) {
    return Semantics(
      button: true,
      label: 'Open user profile menu for Admin',
      child: Tooltip(
        message: 'View Profile',
        child: InkWell(
          key: AppKeys.topNavProfileButton,
          onTap: () => _showSnackbar(context, 'User profile tapped'),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primaryLight,
                child: Text('AD', style: TextStyle(color: AppColors.cardBackground, fontSize: 14)),
              ),
              if (!widget.isMobile) ...[
                const SizedBox(width: 8),
                Text(
                  'Admin',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.textMedium),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}