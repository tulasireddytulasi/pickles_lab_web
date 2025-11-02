import 'package:flutter/material.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_theme.dart';
import 'package:pickles_lab_dashboard/app/core/utils/app_log.dart';

import 'category_pie_chart.dart';
import 'sales_trend_chart.dart';

class ChartWidget extends StatefulWidget {
  const ChartWidget({super.key});

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // Desktop breakpoint is > 768px
      final isDesktop = constraints.maxWidth <= AppBreakpoints.desktop;

      return isDesktop ? Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SalesTrendChart(),
          const SizedBox(height: 20),
          const CategoryPieChart(),
        ],
      ) : Row(
        children: [
          Expanded(flex: 65, child: const SalesTrendChart()),
          const SizedBox(width: 14),
          Expanded(flex: 32, child: const CategoryPieChart()),
        ],
      );
    },);
  }
}
