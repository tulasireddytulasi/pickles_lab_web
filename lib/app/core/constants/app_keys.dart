import 'package:flutter/material.dart';

class AppKeys {
  // Responsive Layout
  static const responsiveLayout = ValueKey('responsiveLayout');

  // Navigation
  static const desktopSidebar = ValueKey('desktopSidebar');
  static const mobileBottomNav = ValueKey('mobileBottomNav');
  static const topNavigationBar = ValueKey('topNavigationBar');

  // Sidebar Items
  static const sidebarItemDashboard = ValueKey('sidebarItemDashboard');
  static const sidebarItemOrders = ValueKey('sidebarItemOrders');
  static const sidebarItemProducts = ValueKey('sidebarItemProducts');
  static const sidebarItemCustomers = ValueKey('sidebarItemCustomers');
  static const sidebarItemAnalytics = ValueKey('sidebarItemAnalytics');
  static const sidebarItemSellers = ValueKey('sidebarItemSellers');
  static const sidebarItemSettings = ValueKey('sidebarItemSettings');
  
  // Top Navigation Bar Items
  static const topNavSearchField = ValueKey('topNavSearchField');
  static const topNavNotificationsButton = ValueKey('topNavNotificationsButton');
  static const topNavSettingsButton = ValueKey('topNavSettingsButton');
  static const topNavProfileButton = ValueKey('topNavProfileButton');

  // Mobile Bottom Navigation Items
  static const bottomNavDashboard = ValueKey('bottomNavDashboard');
  static const bottomNavOrders = ValueKey('bottomNavOrders');
  static const bottomNavProducts = ValueKey('bottomNavProducts');
  static const bottomNavCustomers = ValueKey('bottomNavCustomers');
  static const bottomNavSettings = ValueKey('bottomNavSettings');

  // Screen Widgets
  static const dashboardScreen = ValueKey('dashboardScreen');
  static const ordersScreen = ValueKey('ordersScreen');
  static const productsScreen = ValueKey('productsScreen');
  static const customersScreen = ValueKey('customersScreen');
  static const analyticsScreen = ValueKey('analyticsScreen');
  static const sellersScreen = ValueKey('sellersScreen');
  static const settingsScreen = ValueKey('settingsScreen');


  // Re-usable Widgets
  static const metricCard = ValueKey('metricCard');
  static const chartWidget = ValueKey('chartWidget');
  static const orderListItem = ValueKey('orderListItem');
  static const dashboardHeader = ValueKey('dashboardHeader');
  static const metricCardsList = ValueKey('metricCardsList');
  static const salesTrendChart = ValueKey('salesTrendChart');
  static const topProductsList = ValueKey('topProductsList');
  static const categoryPieChart = ValueKey('categoryPieChart');
  static const orderDetailsModal = ValueKey('orderDetailsModal');
  static const recentOrdersTable = ValueKey('recentOrdersTable');
  static const recentCustomersList = ValueKey('recentCustomersList');
  static const productsCustomersList = ValueKey('productsCustomersList');
  static const recentOrdersContainer = ValueKey('recentOrdersContainer');
}
