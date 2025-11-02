// lib/screens/dashboard/widgets/sales_trend_chart.dart

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_colors.dart';
import 'package:pickles_lab_dashboard/app/data/mock_data/metric_mock_data.dart';

/// A card displaying a line chart for sales trends with time range filtering.
///
/// This is a [StatefulWidget] to manage the selected time period (Weekly/Monthly/Yearly).
class SalesTrendChart extends StatefulWidget {
  const SalesTrendChart({super.key});

  @override
  State<SalesTrendChart> createState() => _SalesTrendChartState();
}

class _SalesTrendChartState extends State<SalesTrendChart> {
  int _selectedIndex = 1; // Default to 'Monthly'
  final List<String> _timeRanges = ['Weekly', 'Monthly', 'Yearly'];

  // Mock data will be fetched here
  late List<ChartData> _salesData;
  final MockDataService _mockService = MockDataService();

  @override
  void initState() {
    super.initState();
    // Use the mock service to get initial data (e.g., last 6 months)
    _salesData = _mockService.getSalesTrendData();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: Title and Tabs
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sales Trend',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                _buildTimeRangeTabs(),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 230,
              child: _buildLineChart(),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the segmented control for time range selection.
  Widget _buildTimeRangeTabs() {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: AppColors.background, // bg-gray-50
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(_timeRanges.length, (index) {
          final isSelected = index == _selectedIndex;
          final theme = Theme.of(context);

          return Semantics(
            button: true,
            label: 'Select ${_timeRanges[index]} view',
            selected: isSelected,
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                  // In a real app, this would trigger an API call to fetch new data.
                  // For now, we simulate data change by re-fetching the same mock data.
                  _salesData = _mockService.getSalesTrendData();
                });
              },
              borderRadius: BorderRadius.circular(6.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.cardBackground : Colors.transparent,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  _timeRanges[index],
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: isSelected ? AppColors.textDark : AppColors.textMedium,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  /// Configures and returns the LineChart widget from fl_chart.
  Widget _buildLineChart() {
    // Determine the max Y-axis value to set proper bounds
    final maxY = _salesData.map((d) => d.value).reduce((a, b) => a > b ? a : b) * 1.2;
    final minY = _salesData.map((d) => d.value).reduce((a, b) => a < b ? a : b) * 0.8;

    // Convert ChartData to FlSpot for fl_chart
    List<FlSpot> spots = List.generate(_salesData.length, (index) {
      return FlSpot(index.toDouble(), _salesData[index].value);
    });

    return LineChart(
      LineChartData(
        // General Configuration
        minX: 0,
        maxX: (_salesData.length - 1).toDouble(),
        minY: minY,
        maxY: maxY,
        gridData: const FlGridData(show: false), // Hide horizontal and vertical lines

        // Title/Axis Configuration
        titlesData: FlTitlesData(
          show: true,
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          // Bottom Titles (X-axis labels)
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                // Display the label from the ChartData (e.g., 'Jan', 'Feb')
                if (value.toInt() < _salesData.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(_salesData[value.toInt()].label,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.textMedium
                      ),
                    ),
                  );
                }
                return Container();
              },
              reservedSize: 30,
            ),
          ),
          // Left Titles (Y-axis labels)
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                // Format Y-axis labels in K's (e.g., 1k, 2k)
                if (value % 500 == 0 && value > 0) {
                  return Text(
                      '${(value / 1000).toInt()}k',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.textLight
                      )
                  );
                }
                return Container();
              },
            ),
          ),
        ),

        // Border Configuration (Only bottom line based on HTML)
        borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(color: AppColors.border, width: 1),
            left: BorderSide.none,
            right: BorderSide.none,
            top: BorderSide.none,
          ),
        ),

        // Line Styling
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: AppColors.primary,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false), // Hide dots
            belowBarData: BarAreaData(
              show: true,
              color: AppColors.primaryBackground, // Use primary/10 color for gradient fill
            ),
          ),
        ],
      ),
    );
  }
}