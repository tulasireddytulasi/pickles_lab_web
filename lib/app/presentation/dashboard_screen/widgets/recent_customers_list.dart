// lib/screens/dashboard/widgets/recent_customers_list.dart (REFACTORED)

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_colors.dart';
import 'package:pickles_lab_dashboard/app/data/mock_data/customer_mock_data.dart';


/// A card component displaying a list of recently registered customers.
class RecentCustomersList extends StatelessWidget {
  const RecentCustomersList({super.key});

  @override
  Widget build(BuildContext context) {
    final customers = CustomerMockDataService().getRecentCustomers();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header (Including "View All")
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Customers',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                // "View All" link
                TextButton(
                  onPressed: () {
                    // Placeholder for navigation to the full Customers page
                  },
                  child: Text(
                    'View All',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.primary, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // List of Customers
            ...customers.map((customer) => _buildCustomerItem(context, customer)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerItem(BuildContext context, Customer customer) {
    final theme = Theme.of(context);
    final currencyFormatter = NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 2);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar Image (using Image.network)
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.border,
            ),
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.only(right: 12),
            child: Image.network(
              customer.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
              const Center(child: Icon(Icons.person, size: 20, color: AppColors.textMedium)),
            ),
          ),

          // Customer Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customer.name,
                  style: theme.textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, size: 14, color: AppColors.textLight),
                    const SizedBox(width: 4),
                    Text(
                      customer.location,
                      style: theme.textTheme.bodySmall!.copyWith(color: AppColors.textMedium),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Total Spent and Date
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                currencyFormatter.format(customer.totalSpent),
                // Apply the success color for the "Total Spent" value
                style: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600, color: AppColors.success),
              ),
              const SizedBox(height: 2),
              Text(
                'Joined: ${DateFormat('MMM d').format(customer.registrationDate)}',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}