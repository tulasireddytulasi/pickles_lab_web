import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pickles_lab_dashboard/app/core/constants/app_keys.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_theme.dart';
import 'package:pickles_lab_dashboard/app/presentation/analytics_screen/analytics_screen.dart';
import 'package:pickles_lab_dashboard/app/presentation/customers_screen/customers_screen.dart';
import 'package:pickles_lab_dashboard/app/presentation/dashboard_screen/dashboard_screen.dart';
import 'package:pickles_lab_dashboard/app/presentation/products_screen/products_screen.dart';
import 'package:pickles_lab_dashboard/app/presentation/sellers_screen/sellers_screen.dart';
import 'package:pickles_lab_dashboard/app/presentation/settings_screen/settings_screen.dart';

import 'app/presentation/orders_screen/Orders_screen.dart';
import 'app/widgets/responsive_layout.dart';

// Router configuration using go_router
final _router = GoRouter(
  initialLocation: '/',
  routes: [
    // 1. ShellRoute: Defines the persistent layout (ResponsiveLayout)
    ShellRoute(
      // The builder is responsible for rendering the shared UI (Sidebar/Top Nav)
      builder: (context, state, child) {
        // 'child' is the widget for the current sub-route (DashboardScreen, OrdersScreen)
        return ResponsiveLayout(
          key: AppKeys.responsiveLayout,
          child: child,
        );
      },
      routes: [
        // 1a. Dashboard Route (Home)
        GoRoute(
          path: '/',
          name: 'dashboard',
          builder: (context, state) => const DashboardScreen(key: AppKeys.dashboardScreen),
        ),
        // 1b. Orders Route
        GoRoute(
          path: '/orders',
          name: 'orders',
          builder: (context, state) => const OrdersScreen(key: AppKeys.ordersScreen),
        ),
        // 1c. Products Route
        GoRoute(
          path: '/products',
          name: 'products',
          builder: (context, state) => const ProductsScreen(key: AppKeys.productsScreen),
        ),
        // 1d. Customers Route
        GoRoute(
          path: '/customers',
          name: 'customers',
          builder: (context, state) => const CustomersScreen(key: AppKeys.customersScreen),
        ),
        // 1e. Analytics Route
        GoRoute(
          path: '/analytics',
          name: 'analytics',
          builder: (context, state) => const AnalyticsScreen(key: AppKeys.analyticsScreen),
        ),
        // 1f. Sellers Route
        GoRoute(
          path: '/sellers',
          name: 'sellers',
          builder: (context, state) => const SellersScreen(key: AppKeys.sellersScreen),
        ),
        // 1g. Settings Route
        GoRoute(
          path: '/settings',
          name: 'settings',
          builder: (context, state) => const SettingsScreen(key: AppKeys.settingsScreen),
        ),
      ],
    ),
  ],
  debugLogDiagnostics: true,
);

/// The main application widget for the Pickles Dashboard.
///
/// This is a [StatelessWidget] that sets up the router and the global theme.
class PicklesDashboardApp extends StatelessWidget {
  const PicklesDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Pickles Dashboard',
      theme: AppTheme.lightTheme,
      routerConfig: _router,
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}