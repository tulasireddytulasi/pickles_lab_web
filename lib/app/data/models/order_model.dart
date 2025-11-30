import 'package:pickles_lab_dashboard/app/core/utils/app_enums.dart';

/// The core data model for a single food order.
class OrderModel {
  final String orderId;
  final String customerName;
  final DateTime orderDate;
  final double totalAmount;
  // Todo: Get the value of order status and add to the enum
  final OrderStatus status;
  final PaymentType paymentStatus;
  final List<OrderItemModel> items; // <-- NEW FIELD

  const OrderModel({
    required this.orderId,
    required this.customerName,
    required this.orderDate,
    required this.totalAmount,
    required this.status,
    required this.paymentStatus,
    required this.items, // <-- REQUIRED IN CONSTRUCTOR
  });
}


/// Defines the structure for a single line item within an Order.
class OrderItemModel {
  final String productName;
  final int quantity;
  final double unitPrice;
  final double itemTotal;

  const OrderItemModel({
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.itemTotal,
  });
}