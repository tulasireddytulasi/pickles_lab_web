import 'package:flutter/material.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.bar_chart_outlined, size: 80, color: Colors.grey),
          const SizedBox(height: 24),
          Text('Analytics Screen', style: Theme.of(context).textTheme.headlineMedium),
        ],
      ),
    );
  }
}
