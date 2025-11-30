// lib/screens/orders/widgets/orders_table.dart

import 'package:flutter/material.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_theme.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_colors.dart';
import 'package:pickles_lab_dashboard/app/data/models/order_model.dart';

import 'order_data_source.dart';
import 'orders_table_cell.dart';

/// The main component displaying the list of orders, responsive to screen size,
/// using PaginatedDataTable for desktop and a ListView of cards for mobile.
class OrdersTable extends StatelessWidget {
  final List<OrderModel> orders;
  final VoidCallback onRefresh;
  final ValueChanged<OrderModel> onEdit;
  final int rowsPerPage;
  final ValueChanged<int?> onRowsPerPageChanged;

  const OrdersTable({
    super.key,
    required this.orders,
    required this.onRefresh,
    required this.onEdit,
    required this.rowsPerPage,
    required this.onRowsPerPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.sizeOf(context).width >= AppBreakpoints.desktop;

    if (orders.isEmpty) {
      return const Center(child: Text('No orders found.'));
    }

    // --- Desktop View: PaginatedDataTable ---
    if (isDesktop) {
      final OrderDataSource dataSource = OrderDataSource(
        orders,
        onRefresh: onRefresh,
        onEdit: onEdit,
      );

      return SizedBox(
        width: double.infinity,
        child: Card(
          // Use Card for the container styling matching the rest of the dashboard
          shape: theme.cardTheme.shape,
          color: AppColors.cardBackground,
          child: PaginatedDataTable(
            // Paging controls
            header: const Text('Recent Orders', style: TextStyle(fontWeight: FontWeight.bold)),
            source: dataSource,
            rowsPerPage: rowsPerPage,
            onRowsPerPageChanged: onRowsPerPageChanged,
            availableRowsPerPage: const [10, 25, 50],
            showCheckboxColumn: false,

            // Style adjustments for a cleaner look
            dataRowMinHeight: 50,
            dataRowMaxHeight: 50,
            columnSpacing: 30, // Tighter spacing than default
            horizontalMargin: 20,

            columns: const [
              DataColumn(label: Text('Order ID')),
              DataColumn(label: Text('Customer')),
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Payment')),
              DataColumn(label: Text('Total', textAlign: TextAlign.right)),
              DataColumn(label: Text('Actions')),
            ],
          ),
        ),
      );
    }

    // --- Mobile/Tablet View: ListView of Cards ---
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        // Note: Pagination on mobile is typically done via infinite scroll or simpler controls.
        // For simplicity here, we display the full filtered list, but OrderScreen can limit the count.
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: OrdersTableCell(
            order: order,
            onEdit: () => onEdit(order),
          ),
        );
      },
    );
  }
}