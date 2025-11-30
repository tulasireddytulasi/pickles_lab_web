// lib/screens/orders/widgets/order_item_summary_cell.dart

import 'package:flutter/material.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_colors.dart';
import 'package:pickles_lab_dashboard/app/data/models/order_model.dart';

/// Displays the summary of order items (circular image + item count).
class OrderItemSummaryCell extends StatelessWidget {
  final OrderModel order;

  const OrderItemSummaryCell({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final itemCount = order.items.length;
    final itemText = itemCount == 1 ? '1 item' : '$itemCount items';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Circular Image Placeholder (Using a generic shopping bag icon)
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: AppColors.border, // Light background for the icon
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Icon(
            Icons.shopping_bag_outlined,
            size: 18,
            color: AppColors.textMedium,
          ),
        ),
        const SizedBox(width: 8),
        // Item Count Text
        Text(
          itemText,
          style: theme.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }
}