import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_theme.dart';
import 'package:pickles_lab_dashboard/app/presentation/dashboard_screen/dashboard_screen.dart';

// Router configuration using go_router
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    // Add more routes here (e.g., /orders, /products)
  ],
  // Use path strategy for Flutter Web URLs (clean URLs)
  // For production, you may need server configuration (e.g., .htaccess or nginx rules)
  // For development, this keeps URLs cleaner.
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