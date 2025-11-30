// lib/screens/orders/widgets/status_chip_bar.dart

import 'package:flutter/material.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_colors.dart';
import 'package:pickles_lab_dashboard/app/core/utils/app_enums.dart';

/// A horizontal bar of clickable chips (pills) for filtering orders by status.
class StatusChipBar extends StatelessWidget {
  final OrderStatus? selectedStatus;
  final ValueChanged<OrderStatus?> onStatusChanged;

  const StatusChipBar({
    super.key,
    required this.selectedStatus,
    required this.onStatusChanged,
  });

  // Helper map to convert enum to display string
  String _statusToString(OrderStatus status) {
    switch (status) {
      case OrderStatus.completed:
        return 'Completed';
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  @override
  Widget build(BuildContext context) {
    // List of statuses including the 'All' option (represented by null)
    final List<OrderStatus?> statuses = [null, ...OrderStatus.values];
    final List<Widget> children = [];

    // Build the chips and add spacing between them
    for (int i = 0; i < statuses.length; i++) {
      final status = statuses[i];
      final isAll = status == null;
      final label = isAll ? 'All' : _statusToString(status);
      final isActive = status == selectedStatus;

      final chip = Semantics(
        button: true,
        selected: isActive,
        label: 'Filter by $label status',
        child: InkWell(
          onTap: () => onStatusChanged(status),
          borderRadius: BorderRadius.circular(20.0), // rounded-full
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), // px-3 py-1
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary : AppColors.border,
              borderRadius: BorderRadius.circular(20.0), // rounded-full
            ),
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                // Use white for active, gray-500 for inactive
                color: isActive ? AppColors.cardBackground : AppColors.textMedium,
                fontWeight: FontWeight.w600, // font-medium
                fontSize: 13, // text-sm
              ),
            ),
          ),
        ),
      );

      children.add(chip);

      // Add spacing if it's not the last item (space-x-2 in HTML)
      if (i < statuses.length - 1) {
        children.add(const SizedBox(width: 8.0));
      }
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}