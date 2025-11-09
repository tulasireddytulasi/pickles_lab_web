import 'package:flutter/material.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_theme.dart';
import 'package:pickles_lab_dashboard/app/data/mock_data/metric_mock_data.dart';

import 'metric_card.dart';

class MetricCardsList extends StatefulWidget {
  const MetricCardsList({super.key});

  @override
  State<MetricCardsList> createState() => _MetricCardsListState();
}

class _MetricCardsListState extends State<MetricCardsList> {
  List<MetricData> metricData = [];

  @override
  void initState() {
    super.initState();
    // Fetch mock data for the metric cards
    metricData = MockDataService().getMetrics();
  }

  /// Calculates the optimal crossAxisCount based on the screen width, matching the requirements.
  int _getCrossAxisCount(double screenWidth) {
    int crossAxisCount;
    if (screenWidth > AppBreakpoints.largeDesktop) {
      // Large Desktop
      crossAxisCount = 3;
    } else if (screenWidth > AppBreakpoints.desktop) {
      // Tablet/Small Desktop
      crossAxisCount = 3;
    } else if (screenWidth > AppBreakpoints.tablet) {
      // Tablet/Small Desktop
      crossAxisCount = 2;
    } else {
      // Mobile
      crossAxisCount = 1;
    }

    return crossAxisCount;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Use a grid with dynamic columns based on screen width
        final screenWidth = constraints.maxWidth;
        final crossAxisCount = _getCrossAxisCount(screenWidth);

        const double gridSpacing = 16.0;

        // 1. Calculate the total width consumed by spacing.
        final double totalHorizontalSpace = gridSpacing * (crossAxisCount > 1 ? crossAxisCount - 1 : 0);

        // 2. Calculate the available width for all cards.
        final double availableGridWidth = screenWidth - totalHorizontalSpace;

        // 3. Calculate the width of a single card.
        final double cardWidth = availableGridWidth / crossAxisCount;

        // 4. Define a fixed height for the card.
        const double desiredCardHeight = 144.0;

        // 5. Calculate the dynamic aspect ratio, ensuring it's always positive.
        final double childAspectRatio = (cardWidth > 0 && desiredCardHeight > 0)
            ? cardWidth / desiredCardHeight
            : 1.0; // Fallback to 1.0 aspect ratio

        // --- End Dynamic Aspect Ratio Calculation ---

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          // Managed by parent SingleChildScrollView
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: gridSpacing,
            mainAxisSpacing: gridSpacing,
          ),
          itemCount: metricData.length,
          itemBuilder: (context, index) {
            return MetricCard(metric: metricData[index]);
          },
        );
      },
    );
  }
}
