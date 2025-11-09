// lib/screens/dashboard/widgets/recent_orders_table.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_colors.dart';
import 'package:pickles_lab_dashboard/app/data/mock_data/metric_mock_data.dart';
import 'data_display/status_badge.dart';
import 'order_details_modal.dart';

/// A table widget that displays a list of recent orders.
///
/// This widget is designed to be displayed in a desktop or tablet view. It uses
/// a [DataTable] to display the order information. The table is horizontally
/// scrollable to accommodate wider content.
///
/// The table displays the following columns:
/// - Order ID
/// - Product
/// - Customer
/// - Order Date
/// - Status
/// - Amount
/// - Actions
class RecentOrdersTable extends StatelessWidget {
  /// A list of orders to be displayed in the table.
  final List<Order> orders;

  /// Creates a new instance of [RecentOrdersTable].
  ///
  /// The [orders] parameter is required and must not be null.
  const RecentOrdersTable({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currencyFormatter = NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 2);

    // Using PaginatedDataTable for scalability is common, but here we use a simple DataTable.
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Allows horizontal scrolling if table is too wide
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: DataTable(
              columnSpacing: 24,
              dataRowMinHeight: 60,
              dataRowMaxHeight: 60,
              headingRowColor: WidgetStateProperty.resolveWith((states) => AppColors.background),
              headingTextStyle: theme.textTheme.bodySmall!.copyWith(
                color: AppColors.textMedium,
                fontWeight: FontWeight.w600,
              ),

              columns: const [
                DataColumn(label: Text('ORDER ID')),
                DataColumn(label: Text('PRODUCT')),
                DataColumn(label: Text('CUSTOMER')),
                DataColumn(label: Text('ORDER DATE')),
                DataColumn(label: Text('STATUS')),
                DataColumn(label: Text('AMOUNT'), numeric: true),
                DataColumn(label: Text('ACTIONS')),
              ],
              rows: orders.map((order) {
                return DataRow(
                  cells: [
                    // Order ID
                    DataCell(Text(order.id, style: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500))),

                    // Product Name (with mock image placeholder)
                    DataCell(
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.border,
                            ),
                            clipBehavior: Clip.antiAlias,
                            margin: const EdgeInsets.only(right: 8),
                            child: Image.network(
                              order.productImageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                              const Center(child: Icon(Icons.broken_image, size: 20, color: AppColors.textMedium)),
                            ),
                          ),
                          Expanded(child: Text(order.productName, style: theme.textTheme.bodyMedium, overflow: TextOverflow.ellipsis,)),
                        ],
                      ),
                    ),

                    // Customer Name
                    DataCell(Text(order.customerName, style: theme.textTheme.bodyMedium)),

                    // Order Date
                    DataCell(Text(DateFormat('MMM d, yyyy').format(order.orderDate), style: theme.textTheme.bodyMedium)),

                    // Status Badge
                    DataCell(StatusBadge(status: order.status)),

                    // Amount
                    DataCell(Text(currencyFormatter.format(order.amount), style: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600))),

                    // Actions (View Button)
                    DataCell(
                      Semantics(
                        button: true,
                        label: 'View details for order \${order.id}',
                        child: Tooltip(
                          message: 'View Details',
                          child: InkWell(
                            onTap: () {
                              showOrderDetailsModal(context: context, orderId: order.id);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.remove_red_eye_outlined, color: AppColors.textMedium, size: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
