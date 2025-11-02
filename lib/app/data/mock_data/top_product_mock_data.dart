// lib/data/mock_data.dart (UPDATED)

// ... (existing imports and other models) ...

/// Represents a top-selling product for the ranking list (UPDATED).
class TopProduct {
  final String productName;
  final int ordersCount; // Changed from salesCount
  final double unitPrice; // Changed from revenue
  final String imageUrl; // New field
  final double rating; // New field

  TopProduct({
    required this.productName,
    required this.ordersCount,
    required this.unitPrice,
    required this.imageUrl,
    required this.rating,
  });
}

// --- Mock Service ---

class TopProductMockDataService {
  // ... (existing helper methods) ...

  /// Generates mock data for the Top Products list based on HTML content.
  List<TopProduct> getTopProducts() {
    // Data extracted directly from Minimalistic-Food-Admin-Dashboard.html
    return [
      TopProduct(
        productName: 'Gourmet Burger',
        ordersCount: 243,
        unitPrice: 18.75,
        imageUrl: 'https://readdy.ai/api/search-image?query=gourmet%20burger%20with%20cheese%2C%20lettuce%2C%20and%20tomato%20on%20a%20wooden%20board%2C%20professional%20food%20photography%2C%20soft%20lighting%2C%20restaurant%20quality&width=100&height=100&seq=food2&orientation=squarish',
        rating: 4.7,
      ),
      TopProduct(
        productName: 'Margherita Pizza',
        ordersCount: 198,
        unitPrice: 16.50,
        imageUrl: 'https://readdy.ai/api/search-image?query=gourmet%20pizza%20with%20fresh%20mozzarella%2C%20basil%2C%20and%20tomatoes%2C%20wood-fired%2C%20professional%20food%20photography%2C%20soft%20lighting%2C%20restaurant%20quality&width=100&height=100&seq=food4&orientation=squarish',
        rating: 4.2,
      ),
      TopProduct(
        productName: 'Sushi Platter',
        ordersCount: 172,
        unitPrice: 32.99,
        imageUrl: 'https://readdy.ai/api/search-image?query=gourmet%20sushi%20platter%20with%20various%20rolls%20and%20sashimi%2C%20served%20on%20a%20black%20plate%20with%20chopsticks%2C%20professional%20food%20photography%2C%20soft%20lighting%2C%20restaurant%20quality&width=100&height=100&seq=food5&orientation=squarish',
        rating: 4.9,
      ),
      TopProduct(
        productName: 'Pasta Primavera',
        ordersCount: 156,
        unitPrice: 24.50,
        imageUrl: 'https://readdy.ai/api/search-image?query=gourmet%20pasta%20dish%20with%20fresh%20basil%20and%20parmesan%2C%20served%20on%20a%20white%20plate%2C%20professional%20food%20photography%2C%20soft%20lighting%2C%20restaurant%20quality&width=100&height=100&seq=food1&orientation=squarish',
        rating: 4.6,
      ),
    ];
  }

// ... (existing getMetrics, getRecentOrders, etc. methods) ...
}