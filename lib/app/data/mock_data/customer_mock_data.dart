import 'dart:math';

/// Represents a recent customer for the customer list (UPDATED).
class Customer {
  final String name;
  final String imageUrl; // New field
  final String location;
  final DateTime registrationDate;
  final double totalSpent;

  Customer({
    required this.name,
    required this.imageUrl,
    required this.location,
    required this.registrationDate,
    required this.totalSpent,
  });
}

// --- Mock Service ---

class CustomerMockDataService {
  static final Random _random = Random();
  // ... (existing helper methods) ...

  /// Generates mock data for the Recent Customers list based on HTML content.
  List<Customer> getRecentCustomers() {
    final List<String> names = ['Sarah Kim', 'David Chen', 'Maria Garcia', 'Jordan Patel', 'Linda Wang', 'Robert Brown'];
    final List<String> locations = ['New York, NY', 'Los Angeles, CA', 'Chicago, IL', 'Miami, FL', 'Seattle, WA', 'Austin, TX'];

    // Using a list of mock avatar URLs
    final List<String> avatarUrls = [
      "https://readdy.ai/api/search-image?query=professional%20portrait%20photo%20of%20a%20young%20woman%20with%20long%20brown%20hair%2C%20smiling%2C%20natural%20lighting%2C%20neutral%20background%2C%20high%20quality%20headshot&width=100&height=100&seq=person1&orientation=squarish",
      "https://readdy.ai/api/search-image?query=professional%20portrait%20photo%20of%20a%20middle-aged%20man%20with%20short%20dark%20hair%20and%20glasses%2C%20smiling%2C%20natural%20lighting%2C%20neutral%20background%2C%20high%20quality%20headshot&width=100&height=100&seq=person2&orientation=squarish",
      "https://readdy.ai/api/search-image?query=professional%20portrait%20photo%20of%20a%20young%20asian%20man%20with%20short%20black%20hair%2C%20smiling%2C%20natural%20lighting%2C%20neutral%20background%2C%20high%20quality%20headshot&width=100&height=100&seq=person3&orientation=squarish",
      "https://readdy.ai/api/search-image?query=professional%20portrait%20photo%20of%20a%20young%20woman%20with%20short%20blonde%20hair%2C%20smiling%2C%20natural%20lighting%2C%20neutral%20background%2C%20high%20quality%20headshot&width=100&height=100&seq=person4&orientation=squarish",
      "https://readdy.ai/api/search-image?query=professional%20portrait%20photo%20of%20a%20middle-aged%20man%20with%20salt%20and%20pepper%20hair%2C%20smiling%2C%20natural%20lighting%2C%20neutral%20background%2C%20high%20quality%20headshot&width=100&height=100&seq=person5&orientation=squarish",
    ];

    return List.generate(6, (index) {
      return Customer(
        name: names[index % names.length],
        imageUrl: avatarUrls[index % avatarUrls.length],
        location: locations[index % locations.length],
        registrationDate: DateTime.now().subtract(Duration(days: index * 5 + 1)),
        totalSpent: (_random.nextInt(1500) + 100) * 1.0, // $100 to $1600
      );
    });
  }
}