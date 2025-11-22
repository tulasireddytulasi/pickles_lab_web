import 'package:flutter/material.dart';
import 'widgets/orders_control_header.dart';

/// A simple placeholder screen for the Orders route.
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OrdersHeader(),
        ],
      ),
    );
  }
}
