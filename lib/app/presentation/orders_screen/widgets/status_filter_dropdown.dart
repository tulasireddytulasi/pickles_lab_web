// lib/widgets/forms/status_filter_dropdown.dart

import 'package:flutter/material.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_colors.dart';
import 'package:pickles_lab_dashboard/app/core/utils/app_enums.dart';

/// A reusable dropdown for filtering orders by OrderStatus.
class StatusFilterDropdown extends StatelessWidget {
  final OrderStatus? selectedStatus;
  final ValueChanged<OrderStatus?> onStatusChanged;

  const StatusFilterDropdown({
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
    final theme = Theme.of(context);

    // Styling matches the look of a TextField input
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: AppColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<OrderStatus?>(
          value: selectedStatus,
          hint: Text(
              'Filter by Status',
              style: theme.textTheme.bodyMedium!.copyWith(color: AppColors.textLight)
          ),
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textMedium),
          style: theme.textTheme.bodyMedium!.copyWith(color: AppColors.textDark),
          isExpanded: true,
          onChanged: onStatusChanged,
          items: [
            // 'All' option (represented by null)
            const DropdownMenuItem(
              value: null,
              child: Text('All Statuses'),
            ),
            // Individual status options
            ...OrderStatus.values.map<DropdownMenuItem<OrderStatus>>((OrderStatus status) {
              return DropdownMenuItem<OrderStatus>(
                value: status,
                child: Text(_statusToString(status)),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}