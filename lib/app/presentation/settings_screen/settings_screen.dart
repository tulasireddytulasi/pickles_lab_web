import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.settings_outlined, size: 80, color: Colors.grey),
          const SizedBox(height: 24),
          Text('Settings Screen', style: Theme.of(context).textTheme.headlineMedium),
        ],
      ),
    );
  }
}
