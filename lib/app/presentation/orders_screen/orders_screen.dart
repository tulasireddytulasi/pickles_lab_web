import 'package:flutter/material.dart';
import 'package:pickles_lab_dashboard/app/core/services/order_service.dart';
import 'package:pickles_lab_dashboard/app/core/utils/app_enums.dart';
import 'package:pickles_lab_dashboard/app/data/models/order_model.dart';
import 'package:pickles_lab_dashboard/app/presentation/orders_screen/widgets/search_filter_bar.dart';
import 'package:pickles_lab_dashboard/app/presentation/orders_screen/widgets/stats_grid.dart';
import 'widgets/orders_control_header.dart';
import 'widgets/orders_table.dart';

/// A simple placeholder screen for the Orders route.
class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {

  // Existing State variables
  List<OrderModel> _allOrders = [];
  List<OrderModel> _filteredOrders = [];
  bool _isLoading = false;
  String _searchQuery = '';
  OrderStatus? _selectedStatusFilter;
  // ... other filter variables (paymentType, orderType, dates)

  // NEW Pagination State Variables
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage; // Default: 10
  int _currentPage = 0;

  final OrderService _orderService = OrderService();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    _filteredOrders = await _orderService.fetchOrders();
    setState(() {

    });
  }

  // Existing methods (_fetchOrders, _applyFilters, _handleCreateNewOrder, etc.)

  // NEW: Handler for rows per page change
  void _handleRowsPerPageChanged(int? newRowsPerPage) {
    if (newRowsPerPage != null) {
      setState(() {
        _rowsPerPage = newRowsPerPage;
        _currentPage = 0; // Reset to first page
      });
    }
  }

  // NEW: Handler for edit action (placeholder for modal implementation)
  void _handleEditOrder(OrderModel order) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Action: Editing Order ${order.orderId}')),
    );
    // Future step will call EditOrderModal here
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OrdersHeader(),

          const SizedBox(height: 32.0),

          // 2. Stats Grid (NEW SECTION)
          const StatsGrid(),

          const SizedBox(height: 32.0),



          // 3. Search and Filter Bar (INTEGRATED)
          SearchFilterBar(
            onSearchChanged: (query) {},
            onStatusChanged: (query) {},
            onPaymentChanged: (query) {},
            onOrderTypeChanged: (query) {},
            onDateChanged: (date, isStart) {},
            onResetTapped: () {},

            // Current values passed down
            selectedStatus: OrderStatus.completed,
            selectedPaymentType: PaymentType.paid,
            selectedOrderType: OrderType.delivery,
            startDate: DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
            ),
            endDate: DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
            ),
          ),

          const SizedBox(height: 32.0),

          // 4. Orders Table (INTEGRATED) - Loading or Data
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else if (_filteredOrders.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(40.0),
                child: Text('No orders found matching your criteria.'),
              ),
            )
          else
            OrdersTable(
              orders: _filteredOrders,
              onRefresh: _orderService.fetchOrders, // Re-use fetch for refresh action
              onEdit: _handleEditOrder,
              rowsPerPage: _rowsPerPage,
              onRowsPerPageChanged: _handleRowsPerPageChanged,
            ),
        ],
      ),
    );
  }
}
