// lib/data/mock_data.dart (UPDATED with TopProduct support)

// ... (existing imports and models) ...

/// Represents a top-selling product for the ranking list.
class TopProduct {
  final String productName;
  final int salesCount;
  final double revenue;

  TopProduct({
    required this.productName,
    required this.salesCount,
    required this.revenue,
  });
}

// --- Mock Service ---

class TopProductMockDataService {
  // ... (existing helper and metric generation methods) ...

  /// Generates mock data for the Top Products list.
  List<TopProduct> getTopProducts() {
    return [
      TopProduct(productName: 'Spicy Dills (Jumbo)', salesCount: 850, revenue: 9875.50),
      TopProduct(productName: 'Sweet Bread & Butter Slices', salesCount: 720, revenue: 7500.00),
      TopProduct(productName: 'Classic Kosher Garlic', salesCount: 610, revenue: 6450.75),
      TopProduct(productName: 'Jalapeño Pickled Asparagus', salesCount: 490, revenue: 5800.00),
      TopProduct(productName: 'Pickle Brine (Gallon)', salesCount: 350, revenue: 4200.00),
      TopProduct(productName: 'Cranberry Relish', salesCount: 200, revenue: 1500.00),
    ];
  }

// ... (existing getMetrics, getRecentOrders, etc. methods) ...
}