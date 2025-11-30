// lib/services/order_service.dart (UPDATED)

import 'dart:math';
import 'package:pickles_lab_dashboard/app/core/utils/app_enums.dart';
import 'package:pickles_lab_dashboard/app/data/models/order_model.dart';

/// Service to fetch mock order data for the dashboard.
class OrderService {
  final Random _random = Random();

  String _generateCustomerName(int index) {
    const names = ['Alice Johnson', 'Bob Smith', 'Charlie Brown', 'Diana Prince', 'Eve Adams', 'Frank Miller', 'Grace Hopper', 'Harry Styles', 'Ivy Queen', 'Jack Miller'];
    return names[_random.nextInt(names.length)];
  }

  /// NEW HELPER: Generates a random list of order items.
  List<OrderItemModel> _generateItems() {
    const products = ['Classic Burger', 'Spicy Fries', 'Veggie Wrap', 'Coke Zero', 'Steak Sandwich', 'Truffle Pasta', 'Pickles Special'];
    final int itemCount = 1 + _random.nextInt(4); // 1 to 4 unique items

    return List.generate(itemCount, (i) {
      final productName = products[_random.nextInt(products.length)];
      final quantity = 1 + _random.nextInt(3); // 1 to 3 quantity
      final unitPrice = double.parse((5.0 + _random.nextDouble() * 25).toStringAsFixed(2));
      final itemTotal = double.parse((unitPrice * quantity).toStringAsFixed(2));

      return OrderItemModel(
        productName: productName,
        quantity: quantity,
        unitPrice: unitPrice,
        itemTotal: itemTotal,
      );
    });
  }

  /// Simulates fetching a list of orders from a backend API.
  Future<List<OrderModel>> fetchOrders() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Generate 50 mock orders
    return List.generate(50, (index) {
      final id = 'ORD-${1000 + index}';
      final customer = _generateCustomerName(index);
      final date = DateTime.now().subtract(Duration(days: _random.nextInt(30)));
      final status = OrderStatus.values[_random.nextInt(OrderStatus.values.length)];
      final payment = PaymentType.values[_random.nextInt(PaymentType.values.length)];

      final items = _generateItems(); // Generate items first
      // Calculate total amount from the generated items
      final total = items.fold(0.0, (sum, item) => sum + item.itemTotal);

      return OrderModel(
        orderId: id,
        customerName: customer,
        orderDate: date,
        totalAmount: double.parse(total.toStringAsFixed(2)),
        status: status,
        paymentStatus: payment,
        items: items, // Pass the item list
      );
    });
  }
}