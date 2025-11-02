import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_colors.dart';

/// The left navigation sidebar visible on desktop screens.
///
/// It is a [StatelessWidget] for layout, relying on child widgets for interaction state.
class DesktopSidebar extends StatelessWidget {
  const DesktopSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    // FIX: Use GoRouterState.of(context).fullPath to get the current route path
    final currentPath = GoRouterState.of(context).fullPath ?? '/';

    // Fixed width based on HTML (256px wide, which is w-64 in Tailwind)
    const double sidebarWidth = 226.0;

    return Container(
      width: sidebarWidth,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.cardBackground, // bg-white
        border: Border(right: BorderSide(color: AppColors.border)), // border-r border-gray-200
      ),
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo/Title Area
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Pickles Admin', // Based on HTML/design intent
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Menu Items (Minimal Placeholder)
          SidebarItem(
            icon: Icons.dashboard_outlined,
            title: 'Dashboard',
            // Check if the current path matches the route
            isSelected: currentPath == '/',
            onTap: () => context.go('/'),
          ),
          const SidebarItem(
            icon: Icons.shopping_cart_outlined,
            title: 'Orders',
            isSelected: false,
            onTap: null, // Placeholder
          ),
          const SidebarItem(
            icon: Icons.shopping_bag_outlined,
            title: 'Products',
            isSelected: false,
            onTap: null, // Placeholder
          ),
          const Spacer(),

          // Premium CTA / Footer (Minimal Placeholder)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.primaryBackground, // bg-primary/10
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                'Upgrade to Premium!',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Reusable widget for individual sidebar menu items.
class SidebarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback? onTap;

  const SidebarItem({
    super.key,
    required this.icon,
    required this.title,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isSelected ? AppColors.primary : AppColors.textMedium;
    final backgroundColor = isSelected ? AppColors.primaryBackground : Colors.transparent;

    return Semantics(
      label: 'Navigate to $title',
      selected: isSelected,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 48,
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 12),
              Text(
                title,
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: color,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}