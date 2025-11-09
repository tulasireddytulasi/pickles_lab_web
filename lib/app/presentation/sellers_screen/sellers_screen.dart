import 'package:flutter/material.dart';

class SellersScreen extends StatelessWidget {
  const SellersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.storefront_outlined, size: 80, color: Colors.grey),
          const SizedBox(height: 24),
          Text('Sellers Screen', style: Theme.of(context).textTheme.headlineMedium),
        ],
      ),
    );
  }
}
