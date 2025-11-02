// lib/screens/dashboard/widgets/recent_orders_container.dart

import 'package:flutter/material.dart';
import 'package:pickles_lab_dashboard/app/data/mock_data/metric_mock_data.dart';
import 'order_list_item.dart';
import 'recent_orders_table.dart';

/// A wrapper widget that manages the title and switches between
/// the Desktop Table and Mobile List view for recent orders.
///
/// This is a [StatelessWidget].
class RecentOrdersContainer extends StatelessWidget {
  const RecentOrdersContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = MockDataService().getRecentOrders();
    final isDesktop = MediaQuery.of(context).size.width >= 769;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Recent Orders',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),

            // Responsive Content Switch
            isDesktop
                ? RecentOrdersTable(orders: orders)
                : Column(
              children: orders.map((order) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: OrderListItem(order: order),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}