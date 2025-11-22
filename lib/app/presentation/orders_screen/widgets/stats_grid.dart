// lib/screens/orders/widgets/stats_grid.dart

import 'package:flutter/material.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_theme.dart';
import 'package:pickles_lab_dashboard/app/data/models/dashboard_stats_model.dart';
import 'package:pickles_lab_dashboard/app/presentation/orders_screen/widgets/stat_card.dart';

/// A responsive grid layout for the summary statistical cards.
///
/// Uses [LayoutBuilder] and [GridView.count] (or similar responsive widget)
/// to adapt the number of columns based on screen width.
class StatsGrid extends StatelessWidget {
  const StatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the mock data for the 4 stats cards
    final stats = OrderDashboardStatsModel.mockStats;

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        int crossAxisCount;

        // Determine the number of columns based on breakpoints
        if (screenWidth >= AppBreakpoints.largeDesktop) {
          crossAxisCount = 4; // Full desktop view
        } else if (screenWidth >= AppBreakpoints.desktop) {
          crossAxisCount = 2; // Tablet/Small desktop view
        } else {
          crossAxisCount = 1; // Mobile view
        }

        return GridView.builder(
          // Important: Prevents GridView from taking infinite height in a Column/ListView
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: stats.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            // Ensure cards have an appropriate height (based on padding and font sizes in StatCard)
            mainAxisExtent: 130.0,
          ),
          itemBuilder: (context, index) {
            return StatCard(stat: stats[index]);
          },
        );
      },
    );
  }
}