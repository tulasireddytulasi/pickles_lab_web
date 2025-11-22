import 'package:flutter/material.dart';
import 'package:pickles_lab_dashboard/app/presentation/orders_screen/widgets/stats_grid.dart';
import 'widgets/orders_control_header.dart';

/// A simple placeholder screen for the Orders route.
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OrdersHeader(),

          const SizedBox(height: 32.0),

          // 2. Stats Grid (NEW SECTION)
          const StatsGrid(),

          const SizedBox(height: 32.0),
        ],
      ),
    );
  }
}
