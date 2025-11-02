// lib/screens/dashboard/widgets/order_list_item.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_colors.dart';
import 'package:pickles_lab_dashboard/app/data/mock_data/metric_mock_data.dart';
import 'data_display/status_badge.dart';
import 'order_details_modal.dart';

/// The Mobile/Card view component for a single Recent Order item.
///
/// This is a [StatelessWidget].
class OrderListItem extends StatelessWidget {
  final Order order;

  const OrderListItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currencyFormatter = NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 2);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Row 1: Product, Amount, and View Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      // Image Placeholder
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.border,
                        ),
                        clipBehavior: Clip.antiAlias,
                        margin: const EdgeInsets.only(right: 12),
                        child: Image.network(
                          order.productImageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                          const Center(child: Icon(Icons.broken_image, size: 20, color: AppColors.textMedium)),
                        ),
                      ),

                      // Product Name and ID
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(order.productName, style: theme.textTheme.titleMedium),
                          const SizedBox(height: 2),
                          Text('ID: ${order.id}', style: theme.textTheme.bodySmall),
                        ],
                      ),
                    ],
                  ),
                ),

                // Amount and View Button
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      currencyFormatter.format(order.amount),
                      style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Semantics(
                      button: true,
                      label: 'View details',
                      child: InkWell(
                        onTap: () {
                          showOrderDetailsModal(context: context, orderId: order.id);
                        },
                        child: Text(
                          'View Details',
                          style: theme.textTheme.bodySmall!.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const Divider(height: 24, color: AppColors.border),

            // Row 2: Customer, Date, and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Customer and Date
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Customer: ${order.customerName}', style: theme.textTheme.bodySmall),
                    const SizedBox(height: 4),
                    Text(
                      'Date: ${DateFormat('MMM d, yyyy').format(order.orderDate)}',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),

                // Status Badge
                StatusBadge(status: order.status),
              ],
            ),
          ],
        ),
      ),
    );
  }
}