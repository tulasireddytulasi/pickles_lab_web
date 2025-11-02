// lib/screens/dashboard/widgets/metric_card.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_colors.dart';
import 'package:pickles_lab_dashboard/app/data/mock_data/metric_mock_data.dart';

/// A reusable card component for displaying a single dashboard metric.
///
/// This is a [StatelessWidget] that displays data passed in via a [MetricData] object.
class MetricCard extends StatelessWidget {
  final MetricData metric;

  const MetricCard({
    super.key,
    required this.metric,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the color for the percentage change text and icon
    final isPositive = metric.change >= 0;
    final trendColor = isPositive ? AppColors.success : AppColors.danger;
    final trendIcon = isPositive ? Icons.arrow_upward : Icons.arrow_downward;

    // Format the metric value and percentage change
    final valueFormatter = NumberFormat.currency(
        locale: 'en_US',
        symbol: metric.unit == '\$' ? '\$' : '', // Only include $ if unit is $
        decimalDigits: metric.unit == '\$' ? 0 : 2
    );
    final formattedValue = valueFormatter.format(metric.value);
    final formattedChange = '${isPositive ? '+' : ''}${metric.change.toStringAsFixed(1)}%';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Row 1: Icon and Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      metric.title,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.textMedium,
                      ),
                    ),
                    // Value
                    Text(
                      metric.unit == '\$' ? formattedValue : '$formattedValue ${metric.unit}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),

                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    // Using a subtle background color defined in AppColors
                    color: metric.iconColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      metric.icon,
                      // Icon size is reduced to fit well within the 40x40 circle
                      size: 24,
                      color: metric.iconColor,
                    ),
                  ),
                ),
              ],
            ),

            // Row 2: Subtext (Comparison text, typically "compared to last month")
            Row(
              children: [
                // Percentage Change Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: trendColor.withValues(alpha: 0.1), // e.g., bg-success/10
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        trendIcon,
                        size: 14,
                        color: trendColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        formattedChange,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: trendColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'vs. last week',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}