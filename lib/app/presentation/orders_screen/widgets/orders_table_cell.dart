// lib/screens/orders/widgets/orders_table_cell.dart

import 'package:flutter/material.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_colors.dart';
import 'package:pickles_lab_dashboard/app/data/models/order_model.dart';
import 'package:pickles_lab_dashboard/app/presentation/dashboard_screen/widgets/data_display/status_badge.dart';
import 'package:intl/intl.dart';

import 'payment_badge.dart';

/// A single card/cell view for an order, used in the responsive mobile layout.
class OrdersTableCell extends StatelessWidget {
  final OrderModel order;
  final VoidCallback onEdit;

  const OrdersTableCell({
    super.key,
    required this.order,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formatter = DateFormat('MMM dd, yyyy');

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row 1: Order ID and Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.orderId,
                  style: theme.textTheme.titleMedium!.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
                ),
                Text(
                  NumberFormat.currency(symbol: '\$').format(order.totalAmount),
                  style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Row 2: Customer Name and Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.customerName,
                  style: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  formatter.format(order.orderDate),
                  style: theme.textTheme.bodySmall!.copyWith(color: AppColors.textMedium),
                ),
              ],
            ),
            const Divider(height: 24),

            // Row 3: Status, Payment, and Action Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Status', style: TextStyle(fontSize: 10, color: AppColors.textLight)),
                    const SizedBox(height: 4),
                    StatusBadge(status: order.status.name),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Payment', style: TextStyle(fontSize: 10, color: AppColors.textLight)),
                    const SizedBox(height: 4),
                    PaymentBadge(status: order.paymentStatus),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 20, color: AppColors.textMedium),
                  tooltip: 'Edit Order',
                  onPressed: onEdit,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}