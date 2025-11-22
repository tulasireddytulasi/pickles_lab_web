// lib/models/dashboard_stats_model.dart

import 'package:flutter/material.dart';

/// Defines the structure and visual properties for a single statistical card
/// in the dashboard's summary grid.
class OrderDashboardStatsModel {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  const OrderDashboardStatsModel({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  });

  // Mock data based on HTML analysis (assuming 4 cards: Total Orders, Revenue, Pending, Cancelled)
  static const List<OrderDashboardStatsModel> mockStats = [
    OrderDashboardStatsModel(
      title: 'Total Orders',
      value: '2,500',
      icon: Icons.shopping_bag_outlined,
      iconColor: Color(0xFF3B82F6), // Blue
      backgroundColor: Color(0xFFEFF6FF), // Light Blue
    ),
    OrderDashboardStatsModel(
      title: 'Total Revenue',
      value: '\$12,450',
      icon: Icons.account_balance_wallet_outlined,
      iconColor: Color(0xFF10B981), // Green (Success)
      backgroundColor: Color(0xFFE0F7E9), // Light Green
    ),
    OrderDashboardStatsModel(
      title: 'Pending Orders',
      value: '150',
      icon: Icons.access_time_outlined,
      iconColor: Color(0xFFFFC107), // Amber (Secondary)
      backgroundColor: Color(0xFFFFFBEB), // Light Amber
    ),
    OrderDashboardStatsModel(
      title: 'Cancelled Orders',
      value: '25',
      icon: Icons.cancel_outlined,
      iconColor: Color(0xFFEF4444), // Red (Danger)
      backgroundColor: Color(0xFFFFE5E5), // Light Red
    ),
  ];
}