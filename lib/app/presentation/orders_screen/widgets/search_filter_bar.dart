// lib/screens/orders/widgets/search_filter_bar.dart

import 'package:flutter/material.dart';
import 'package:pickles_lab_dashboard/app/core/constants/app_keys.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_colors.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_theme.dart';
import 'package:pickles_lab_dashboard/app/core/utils/app_enums.dart';
import 'status_filter_dropdown.dart';

// Callback function type definitions for clarity
typedef OnSearchChanged = void Function(String query);
typedef OnStatusChanged = void Function(OrderStatus? status);
typedef OnDateChanged = void Function(DateTime date, bool isStart);
typedef OnPaymentChanged = void Function(PaymentType type);
typedef OnOrderTypeChanged = void Function(OrderType type);
typedef OnResetTapped = void Function();


/// A responsive, two-row container for all dashboard search and filter controls.
class SearchFilterBar extends StatelessWidget {
  final OnSearchChanged onSearchChanged;
  final OnStatusChanged onStatusChanged;
  final OnDateChanged onDateChanged;
  final OnPaymentChanged onPaymentChanged;
  final OnOrderTypeChanged onOrderTypeChanged;
  final OnResetTapped onResetTapped;

  // Current filter values (passed from the parent stateful widget)
  final OrderStatus? selectedStatus;
  final PaymentType selectedPaymentType;
  final OrderType selectedOrderType;
  final DateTime? startDate;
  final DateTime? endDate;

  const SearchFilterBar({
    super.key,
    required this.onSearchChanged,
    required this.onStatusChanged,
    required this.onDateChanged,
    required this.onPaymentChanged,
    required this.onOrderTypeChanged,
    required this.onResetTapped,
    this.selectedStatus,
    required this.selectedPaymentType,
    required this.selectedOrderType,
    this.startDate,
    this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = MediaQuery.sizeOf(context).width < AppBreakpoints.desktop;

    // Uses a Column of two Wrap widgets for responsive layout
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Row 1: Search and Status Filter ---
        Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            // 1. Search Input Field (Takes fixed space on desktop, flexible on mobile)
            SizedBox(
              width: isMobile ? MediaQuery.sizeOf(context).width - 32 : 300,
              child: TextFormField(
                key: AppKeys.ordersSearchBar,
                decoration: const InputDecoration(
                  hintText: 'Search by Customer, Order ID, or Product...',
                  prefixIcon: Icon(Icons.search, color: AppColors.textMedium, size: 20),
                ),
                onChanged: onSearchChanged,
              ),
            ),

            // 2. Status Filter Dropdown
            SizedBox(
              width: isMobile ? null : 180,
              child: StatusFilterDropdown(
                selectedStatus: selectedStatus,
                onStatusChanged: onStatusChanged,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16.0),

        // --- Row 2: Date, Payment, Order Type, and Reset ---
        Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            // 3. Start Date Selection
            _buildDateSelector(context, theme, 'Start Date', startDate, (date) => onDateChanged(date, true)),

            // 4. End Date Selection
            _buildDateSelector(context, theme, 'End Date', endDate, (date) => onDateChanged(date, false)),

            // 5. Payment Dropdown
            _buildGenericDropdown<PaymentType>(
              context,
              theme,
              'Payment Type',
              selectedPaymentType,
              PaymentType.values,
                  (type) => type == PaymentType.all ? 'All Payments' : type.name.replaceFirst(type.name[0], type.name[0].toUpperCase()),
              onPaymentChanged,
            ),

            // 6. Order Type Dropdown
            _buildGenericDropdown<OrderType>(
              context,
              theme,
              'Order Type',
              selectedOrderType,
              OrderType.values,
                  (type) => type == OrderType.all ? 'All Types' : type.name.replaceFirst(type.name[0], type.name[0].toUpperCase()),
              onOrderTypeChanged,
            ),

            // 7. Reset Button
            Semantics(
              button: true,
              label: 'Reset all applied filters',
              child: OutlinedButton.icon(
                onPressed: onResetTapped,
                icon: const Icon(Icons.refresh, size: 18, color: AppColors.textMedium),
                label: Text(
                  'Reset Filters',
                  style: theme.textTheme.bodyMedium!.copyWith(color: AppColors.textMedium, fontWeight: FontWeight.w500),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.border),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Helper to build the date selection button/field.
  Widget _buildDateSelector(BuildContext context, ThemeData theme, String hintText, DateTime? selectedDate, ValueChanged<DateTime> onChanged) {
    String displayString = selectedDate != null
        ? '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}'
        : hintText;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: AppColors.border),
      ),
      child: InkWell(
        onTap: () async {
          // Mock date selection interaction
          onChanged(selectedDate ?? DateTime.now());
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.calendar_today_outlined, size: 18, color: AppColors.textMedium),
            const SizedBox(width: 8),
            Text(
              displayString,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: selectedDate != null ? AppColors.textDark : AppColors.textLight,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper to build a generic filter dropdown (Payment Type, Order Type).
  Widget _buildGenericDropdown<T>(
      BuildContext context,
      ThemeData theme,
      String hintText,
      T value,
      List<T> items,
      String Function(T) itemToString,
      ValueChanged<T> onChanged,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: AppColors.border),
      ),
      constraints: const BoxConstraints(minWidth: 150),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          hint: Text(
              hintText,
              style: theme.textTheme.bodyMedium!.copyWith(color: AppColors.textLight)
          ),
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textMedium),
          style: theme.textTheme.bodyMedium!.copyWith(color: AppColors.textDark),
          onChanged: (T? newValue) {
            if (newValue != null) {
              onChanged(newValue);
            }
          },
          items: items.map<DropdownMenuItem<T>>((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(itemToString(item)),
            );
          }).toList(),
        ),
      ),
    );
  }
}