// lib/data/mock_data.dart

import 'dart:math';

import 'package:flutter/material.dart';

// --- Data Models ---

/// Represents a key metric displayed at the top of the dashboard.
class MetricData {
  final String title;
  final double value;
  final double change;
  final String unit;
  final IconData icon;

  const MetricData({
    required this.title,
    required this.value,
    required this.change,
    required this.unit,
    required this.icon,
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
      ),
      MetricData(
        title: 'Total Orders',
        value: 1895,
        change: _random.nextDouble() * (10 - 5) + 5, // 5% to 10%
        unit: 'Orders',
        icon: Icons.shopping_cart_outlined,
      ),
      MetricData(
        title: 'New Customers',
        value: 320,
        change: -(_random.nextDouble() * (5 - 1) + 1), // -1% to -5%
        unit: 'People',
        icon: Icons.people_outline,
      ),
      MetricData(
        title: 'Avg. Order Value',
        value: 66.64,
        change: _random.nextDouble() * (8 - 3) + 3, // 3% to 8%
        unit: '\$',
        icon: Icons.receipt_long_outlined,
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
}