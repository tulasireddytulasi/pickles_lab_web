// lib/screens/dashboard/widgets/desktop_sidebar.dart (UPDATED)

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pickles_lab_dashboard/app/core/constants/app_keys.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_colors.dart';

/// The left navigation sidebar visible on desktop screens.
class DesktopSidebar extends StatelessWidget {
  const DesktopSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    // FIX: Use GoRouterState.of(context).fullPath to get the current route path
    // We use a safe check for the path, defaulting to '/' for the dashboard.
    final currentPath = GoRouterState.of(context).fullPath ?? '/';

    // Fixed width based on HTML (240px wide which is w-60, 226px is fine)
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
              style: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 32),

          // Menu Items (Fully Implemented)
          SidebarItem(
            key: AppKeys.sidebarItemDashboard,
            icon: Icons.dashboard_outlined,
            title: 'Dashboard',
            path: '/',
            // Define the route path
            isSelected: currentPath == '/',
            onTap: () => context.go('/'),
          ),
          SidebarItem(
            key: AppKeys.sidebarItemOrders,
            // HTML: ri-shopping-bag-3-line
            icon: Icons.shopping_bag_outlined,
            title: 'Orders',
            path: '/orders',
            isSelected: currentPath.startsWith('/orders'),
            onTap: () => context.go('/orders'),
          ),
          SidebarItem(
            key: AppKeys.sidebarItemProducts,
            // HTML: ri-store-2-line
            icon: Icons.store_outlined,
            title: 'Products',
            path: '/products',
            isSelected: currentPath.startsWith('/products'),
            onTap: () => context.go('/products'),
          ),
          SidebarItem(
            key: AppKeys.sidebarItemCustomers,
            // HTML: ri-user-3-line
            icon: Icons.people_outlined,
            title: 'Customers',
            path: '/customers',
            isSelected: currentPath.startsWith('/customers'),
            onTap: () => context.go('/customers'),
          ),
          SidebarItem(
            key: AppKeys.sidebarItemAnalytics,
            // HTML: ri-bar-chart-2-line
            icon: Icons.bar_chart_outlined,
            title: 'Analytics',
            path: '/analytics',
            isSelected: currentPath.startsWith('/analytics'),
            onTap: () => context.go('/analytics'),
          ),
          SidebarItem(
            key: AppKeys.sidebarItemSellers,
            // HTML: ri-store-3-line
            icon: Icons.storefront_outlined,
            title: 'Sellers/Merchants',
            path: '/sellers',
            isSelected: currentPath.startsWith('/sellers'),
            onTap: () => context.go('/sellers'),
          ),
          SidebarItem(
            key: AppKeys.sidebarItemSettings,
            // HTML: ri-settings-4-line
            icon: Icons.settings_outlined,
            title: 'Settings',
            path: '/settings',
            isSelected: currentPath.startsWith('/settings'),
            onTap: () => context.go('/settings'),
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
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.primary),
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
  final String path; // New: Add path property
  final bool isSelected;
  final VoidCallback? onTap;

  const SidebarItem({
    super.key,
    required this.icon,
    required this.title,
    required this.path, // Required
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
          decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(6.0)),
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
