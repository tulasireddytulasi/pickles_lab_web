// lib/screens/dashboard/dashboard_screen.dart

import 'package:flutter/material.dart';
import 'package:pickles_lab_dashboard/app/widgets/responsive_layout.dart';
import 'widgets/chart_widget.dart';
import 'widgets/dashboard_header.dart';
import 'widgets/metric_cards_list.dart';
import 'widgets/recent_orders_container.dart';

/// The root screen for the Pickles Dashboard view.
///
/// This is a [StatelessWidget] that uses the ResponsiveLayout
/// to handle the overall screen structure (sidebar, top nav, bottom nav).
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder for the full dashboard content (Header, Metrics, Charts, Tables)
    final dashboardContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Dashboard Header (Title, Date Selector, Export Button)
        const DashboardHeader(),

        const SizedBox(height: 24.0), // Spacing below the header

        // Placeholder for the main content widgets (Header, Metrics, Charts, Tables)
        const MetricCardsList(),

        // 3. Sales Trend Chart (Takes full width) chart_widget
        const ChartWidget(),

        // 4. Recent Orders Table/List
        const RecentOrdersContainer(),


        const Text('Content placeholder...'),
        const SizedBox(height: 1200),
        const Text('End of content placeholder...'),
      ],
    );

    return ResponsiveLayout(child: dashboardContent);
  }
}
