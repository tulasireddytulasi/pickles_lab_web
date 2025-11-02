// lib/data/mock_data.dart (UPDATED with DetailedOrder support)

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_colors.dart';

// --- Data Models ---

/// Represents a key metric displayed at the top of the dashboard.
class MetricData {
  final String title;
  final double value;
  final double change;
  final String unit;
  final IconData icon;
  final Color iconColor;

  const MetricData({
    required this.title,
    required this.value,
    required this.change,
    required this.unit,
    required this.icon,
    required this.iconColor,
  });
}

/// Represents an item in the Recent Orders table/list.
class Order {
  final String id;
  final String productName;
  final String productImageUrl;
  final String customerName;
  final DateTime orderDate;
  final String status; // Completed, Processing, Cancelled
  final double amount;

  Order({
    required this.id,
    required this.productName,
    required this.productImageUrl,
    required this.customerName,
    required this.orderDate,
    required this.status,
    required this.amount,
  });
}

/// Represents a data point for a chart.
class ChartData {
  final String label;
  final double value;

  ChartData({required this.label, required this.value});
}

/// Represents a slice in the pie chart (Product Category).
class PieData {
  final String category;
  final double salesPercentage; // 0.0 to 1.0
  final Color color;

  PieData({
    required this.category,
    required this.salesPercentage,
    required this.color,
  });
}

/// Represents a single product line item in the detailed order view.
class OrderItem {
  final String productName;
  final int quantity;
  final double unitPrice;
  final double totalPrice;

  OrderItem({
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
  });
}

/// Represents the full detailed data structure for a single order.
class DetailedOrder {
  final Order baseOrder; // The basic data available in the table
  final String customerEmail;
  final String shippingAddress;
  final String paymentMethod;
  final double subtotal;
  final double shippingFee;
  final double totalAmount;
  final List<OrderItem> items;

  DetailedOrder({
    required this.baseOrder,
    required this.customerEmail,
    required this.shippingAddress,
    required this.paymentMethod,
    required this.subtotal,
    required this.shippingFee,
    required this.totalAmount,
    required this.items,
  });
}


// --- Mock Service ---

/// A service class to provide fake/mock data for the dashboard.
class MockDataService {
  static final Random _random = Random();

  /// Generates mock data for the four metric cards.
  List<MetricData> getMetrics() {
    return [
      MetricData(
        title: 'Total Sales',
        value: 12628,
        change: _random.nextDouble() * (20 - 10) + 10, // 10% to 20%
        unit: '\$',
        icon: Icons.attach_money_outlined,
        iconColor: AppColors.success,
      ),
      MetricData(
        title: 'Active Orders',
        value: 866,
        change: _random.nextDouble() * (10 - 5) + 5, // 5% to 10%
        unit: 'Orders',
        icon: Icons.shopping_cart_outlined,
        iconColor: AppColors.secondary,
      ),
      MetricData(
        title: 'New Customers',
        value: 320,
        change: -(_random.nextDouble() * (5 - 1) + 1), // -1% to -5%
        unit: 'People',
        icon: Icons.people_outline,
        iconColor: AppColors.info,
      ),
    ];
  }

  /// Generates mock data for the Recent Orders list.
  List<Order> getRecentOrders() {
    final List<String> products = ['Pickle Jar (Large)', 'Spicy Pickles', 'Sweet Relish', 'Pickle Juice', 'Gherkins'];
    final List<String> customers = ['Alex Johnson', 'Samantha Lee', 'Chris Miller', 'Dana Cruz', 'Tom Hanks'];
    final List<String> statuses = ['Completed', 'Processing', 'Cancelled'];

    return List.generate(10, (index) {
      final status = statuses[_random.nextInt(statuses.length)];
      return Order(
        id: 'ORD-${1000 + index}',
        productName: products[_random.nextInt(products.length)],
        // Use a placeholder image path
        productImageUrl: 'assets/images/pickle_${_random.nextInt(5) + 1}.png',
        customerName: customers[_random.nextInt(customers.length)],
        orderDate: DateTime.now().subtract(Duration(days: index)),
        status: status,
        amount: (_random.nextInt(2000) + 100) / 10.0, // $10.0 to $200.0
      );
    });
  }

  // Stored list of mock orders for consistency
  static final List<Order> _mockOrders = MockDataService().getRecentOrders();

  /// Generates mock data for the Sales Trend Chart.
  List<ChartData> getSalesTrendData() {
    return [
      ChartData(label: 'Jan', value: 1000),
      ChartData(label: 'Feb', value: 1200),
      ChartData(label: 'Mar', value: 900),
      ChartData(label: 'Apr', value: 1500),
      ChartData(label: 'May', value: 1800),
      ChartData(label: 'Jun', value: 2500),
    ];
  }

  /// Generates mock data for the Product Category Pie Chart.
  List<PieData> getCategorySales() {
    return [
      PieData(category: 'Pickle Jars', salesPercentage: 0.40, color: const Color(0xFF4CAF50)),
      PieData(category: 'Relishes', salesPercentage: 0.25, color: const Color(0xFFFFC107)),
      PieData(category: 'Spicy Varieties', salesPercentage: 0.15, color: const Color(0xFF3F51B5)),
      PieData(category: 'Fermented Veg', salesPercentage: 0.10, color: const Color(0xFF00BCD4)),
      PieData(category: 'Bulk/Wholesale', salesPercentage: 0.10, color: const Color(0xFFF44336)),
    ];
  }

  // *** DEFINED METHOD TO FIX THE ERROR ***
  /// Retrieves a mock detailed order object based on its ID.
  DetailedOrder getDetailedOrder(String orderId) {
    // Find the base order from the list (or create a new mock if not found)
    final baseOrder = _mockOrders.firstWhere(
          (order) => order.id == orderId,
      orElse: () => Order(
        id: orderId,
        productName: 'Custom Mix',
        productImageUrl: '',
        customerName: 'Default User',
        orderDate: DateTime.now(),
        status: 'Processing',
        amount: 150.00,
      ),
    );

    // Generate mock line items
    final item1 = OrderItem(productName: baseOrder.productName, quantity: 2, unitPrice: baseOrder.amount / 2, totalPrice: baseOrder.amount);
    final item2 = OrderItem(productName: 'Pickle Chips', quantity: 1, unitPrice: 20.00, totalPrice: 20.00);
    final items = [item1, item2];

    // Calculate totals
    final subtotal = items.fold(0.0, (sum, item) => sum + item.totalPrice);
    const shippingFee = 7.50;
    final totalAmount = subtotal + shippingFee;

    return DetailedOrder(
      baseOrder: baseOrder,
      customerEmail: '${baseOrder.customerName.replaceAll(' ', '.').toLowerCase()}@example.com',
      shippingAddress: '123 Dill Street, Pickle City, PC 90210',
      paymentMethod: 'Visa ending in 4242',
      subtotal: subtotal,
      shippingFee: shippingFee,
      totalAmount: totalAmount,
      items: items,
    );
  }
}