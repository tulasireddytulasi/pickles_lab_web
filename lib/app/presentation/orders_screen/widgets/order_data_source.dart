// lib/screens/orders/widgets/order_data_source.dart

import 'package:flutter/material.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_colors.dart';
import 'package:pickles_lab_dashboard/app/data/models/order_model.dart';
import 'package:pickles_lab_dashboard/app/presentation/dashboard_screen/widgets/data_display/status_badge.dart';
import 'package:intl/intl.dart';

import 'order_item_summary_cell.dart';
import 'payment_badge.dart';

/// Implements the logic required for PaginatedDataTable (Desktop View).
class OrderDataSource extends DataTableSource {
  final List<OrderModel> orders;
  final VoidCallback onRefresh;
  final ValueChanged<OrderModel> onEdit;

  OrderDataSource(this.orders, {required this.onRefresh, required this.onEdit});

  @override
  DataRow? getRow(int index) {
    if (index >= orders.length) {
      return null;
    }
    final order = orders[index];
    final formatter = DateFormat('MMM dd, yyyy');

    return DataRow.byIndex(
      index: index,
      cells: [
        // 1. Order ID (Hyperlink look)
        DataCell(
          InkWell(
            onTap: () => _showSnackbar(order.orderId),
            child: Text(
              order.orderId,
              style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        // 2. Customer
        DataCell(Text(order.customerName)),
        // 3. Date
        DataCell(Text(formatter.format(order.orderDate))),

        // 3. Items (NEW CELL)
        DataCell(OrderItemSummaryCell(order: order)),

        // 4. Status
        DataCell(StatusBadge(status: order.status.name)),
        // 5. Payment Status
        DataCell(PaymentBadge(status: order.paymentStatus)),
        // 6. Total
        DataCell(Text(NumberFormat.currency(symbol: '\$').format(order.totalAmount))),
        // 7. Actions (Edit Button)
        DataCell(
          IconButton(
            icon: const Icon(Icons.edit_outlined, size: 20, color: AppColors.textMedium),
            tooltip: 'Edit Order ${order.orderId}',
            onPressed: () => onEdit(order),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => orders.length;

  @override
  int get selectedRowCount => 0;

  void _showSnackbar(String orderId) {
    // This requires a GlobalKey or Navigator context from the root,
    // but for mock purposes, we print a message.
    debugPrint('Order $orderId details tapped.');
  }
}