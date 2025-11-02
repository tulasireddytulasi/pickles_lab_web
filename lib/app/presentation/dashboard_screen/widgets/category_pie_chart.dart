// lib/screens/dashboard/widgets/category_pie_chart.dart

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_colors.dart';
import 'package:pickles_lab_dashboard/app/data/mock_data/pie_mock_data.dart';

/// A card displaying a pie chart for product category sales distribution.
///
/// This is a [StatelessWidget] for data visualization.
class CategoryPieChart extends StatelessWidget {
  const CategoryPieChart({super.key});

  // Fetch mock data
  List<PieData> get _data => PieMockDataService().getCategorySales();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Product Categories Sales',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 16),

            // Chart and Legend Layout (Flex to ensure responsive wrapping)
            Row(
              children: [
                Expanded(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // 1. The Donut Chart (Fixed Size)
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: _buildPieChart(context),
                      ),

                      // 2. The Legend/Indicators
                      Positioned(
                        right: 10,
                        child: _buildLegend(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Configures and returns the PieChart widget from fl_chart.
  Widget _buildPieChart(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: _data.map((pieData) {
          return PieChartSectionData(
            color: pieData.color,
            value: pieData.salesPercentage * 100, // Convert to value for fl_chart
            title: '${(pieData.salesPercentage * 100).toStringAsFixed(0)}%',
            radius: 50,
            titleStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: AppColors.cardBackground,
              fontWeight: FontWeight.w600,
            ),
            titlePositionPercentageOffset: 0.55,
          );
        }).toList(),

        // Donut Configuration
        sectionsSpace: 0,
        centerSpaceRadius: 40, // Center space for donut effect
        startDegreeOffset: -90, // Start from the top

        // Touch interaction is complex to implement in stateless, leaving it out for now.
        // pieTouchData: PieTouchData(enabled: false),
      ),
    );
  }

  /// Builds the legend list next to the chart.
  Widget _buildLegend(BuildContext context) {
    final totalSales = 12628; // Use mock sales total from MetricCard data for context
    final numberFormatter = NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 0);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _data.map((pieData) {
        // Calculate the mock amount based on the percentage
        final amount = pieData.salesPercentage * totalSales;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Color Indicator Dot
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: pieData.color,
                ),
                margin: const EdgeInsets.only(right: 8.0),
              ),

              // Category Name and Value
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pieData.category,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.textDark,
                    ),
                  ),
                  Text(
                    '${numberFormatter.format(amount)} (${(pieData.salesPercentage * 100).toStringAsFixed(1)}%)',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.textMedium,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}