// lib/models/order_filter_enums.dart

/// Enum for filtering orders by payment type.
enum PaymentType {
  all,
  paid,
  pending,
  refunded,
}

/// Enum for filtering orders by type (e-commerce specific).
enum OrderType {
  all,
  dineIn,
  takeout,
  delivery,
}

enum OrderStatus {
  completed,
  pending,
  shipped,
  cancelled,
}