// lib/widgets/stat_card.dart

import 'package:flutter/material.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_colors.dart';
import 'package:pickles_lab_dashboard/app/data/models/dashboard_stats_model.dart';

/// A reusable card component used to display a single key performance indicator (KPI).
class StatCard extends StatelessWidget {
  final OrderDashboardStatsModel stat;

  const StatCard({super.key, required this.stat});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      // Card uses the default theme styling (rounded-button, white background)
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Row for Icon and Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title (e.g., Total Orders)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      stat.title,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: AppColors.textMedium, // Gray-500
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 16.0),

                    // Main Value (e.g., $12,450)
                    Text(
                      stat.value.trim(),
                      textAlign: TextAlign.start,
                      style: theme.textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark, // Gray-800
                      ),
                    ),
                  ],
                ),
                // Icon (with custom background color)
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(color: stat.backgroundColor, borderRadius: BorderRadius.circular(8.0)),
                  child: Icon(stat.icon, color: stat.iconColor, size: 24),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
