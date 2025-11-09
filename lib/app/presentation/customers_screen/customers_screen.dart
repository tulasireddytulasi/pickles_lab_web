import 'package:flutter/material.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.people_outlined, size: 80, color: Colors.grey),
          const SizedBox(height: 24),
          Text('Customers Screen', style: Theme.of(context).textTheme.headlineMedium),
        ],
      ),
    );
  }
}
