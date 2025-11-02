// lib/data/mock_data.dart (UPDATED)

import 'dart:math';
import 'package:flutter/material.dart';

// --- Data Models ---

// Existing MetricData, Order, ChartData...

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

// --- Mock Service ---

/// A service class to provide fake/mock data for the dashboard.
class PieMockDataService {
  static final Random _random = Random();

  // Existing getMetrics, getRecentOrders, getSalesTrendData...

  /// Generates mock data for the Product Category Pie Chart.
  List<PieData> getCategorySales() {
    // These colors are used to match the general dashboard palette.
    return [
      PieData(
          category: 'Pickle Jars',
          salesPercentage: 0.40, // 40%
          color: const Color(0xFF4CAF50) // Primary Green
      ),
      PieData(
          category: 'Relishes',
          salesPercentage: 0.25, // 25%
          color: const Color(0xFFFFC107) // Secondary Amber
      ),
      PieData(
          category: 'Spicy Varieties',
          salesPercentage: 0.15, // 15%
          color: const Color(0xFF3F51B5) // Indigo
      ),
      PieData(
          category: 'Fermented Veg',
          salesPercentage: 0.10, // 10%
          color: const Color(0xFF00BCD4) // Cyan
      ),
      PieData(
          category: 'Bulk/Wholesale',
          salesPercentage: 0.10, // 10%
          color: const Color(0xFFF44336) // Red
      ),
    ];
  }
}