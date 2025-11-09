import 'package:flutter/material.dart';
import 'package:pickles_lab_dashboard/app/core/constants/app_keys.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_colors.dart';

/// The bottom navigation bar visible on mobile screens.
///
/// This is a [StatelessWidget] providing basic navigation for smaller screens.
class MobileBottomNav extends StatelessWidget {
  const MobileBottomNav({super.key});

  // Hardcoded for now, would typically be managed by the main screen state
  final int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.cardBackground, // bg-white
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          // TODO: Implement actual navigation (e.g., context.go('/orders'))
        },
        backgroundColor: AppColors.cardBackground,
        type: BottomNavigationBarType.fixed, // Ensure items don't shift
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textMedium,
        selectedLabelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600),
        unselectedLabelStyle: Theme.of(context).textTheme.bodySmall,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: KeyedSubtree(
              key: AppKeys.bottomNavDashboard,
              child: Icon(Icons.dashboard_outlined),
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: KeyedSubtree(
              key: AppKeys.bottomNavOrders,
              child: Icon(Icons.shopping_cart_outlined),
            ),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: KeyedSubtree(
              key: AppKeys.bottomNavProducts,
              child: Icon(Icons.shopping_bag_outlined),
            ),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: KeyedSubtree(
              key: AppKeys.bottomNavCustomers,
              child: Icon(Icons.person_outline),
            ),
            label: 'Customers',
          ),
          BottomNavigationBarItem(
            icon: KeyedSubtree(
              key: AppKeys.bottomNavSettings,
              child: Icon(Icons.settings_outlined),
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}