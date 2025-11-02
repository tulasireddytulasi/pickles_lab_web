// lib/screens/dashboard/widgets/top_products_list.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_colors.dart';
import 'package:pickles_lab_dashboard/app/data/mock_data/top_product_mock_data.dart';

/// A card component displaying a ranked list of top-selling products.
class TopProductsList extends StatelessWidget {
  const TopProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    final products = TopProductMockDataService().getTopProducts();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header (Ensures "View All" functionality is present)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Top Products',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                // "View All" link
                TextButton(
                  onPressed: () {
                    // Placeholder for navigation to the full Products page
                  },
                  child: Text(
                    'View All',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.primary, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // List of Products
            ...products.map((product) => _buildProductItem(context, product)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(BuildContext context, TopProduct product) {
    final theme = Theme.of(context);
    final currencyFormatter = NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 2);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image using Image.network (simulating CachedNetworkImage)
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.border,
            ),
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.only(right: 12),
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
              const Center(child: Icon(Icons.broken_image, size: 20, color: AppColors.textMedium)),
            ),
          ),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.productName,
                      style: theme.textTheme.titleMedium!.copyWith(fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Unit Price
                    Text(
                      currencyFormatter.format(product.unitPrice),
                      style: theme.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Orders Count
                    Text(
                      '${product.ordersCount} orders',
                      style: theme.textTheme.bodySmall!.copyWith(
                        color: AppColors.textMedium,
                      ),
                    ),

                    // Star Rating Component
                    _buildStarRating(product.rating),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStarRating(double rating) {
    final int fullStars = rating.floor();
    final bool hasHalfStar = (rating - fullStars) >= 0.25 && (rating - fullStars) < 0.75;
    final int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Full Stars
        ...List.generate(fullStars, (index) =>
        const Icon(Icons.star_rate_rounded, color: AppColors.secondary, size: 14)),

        // Half Star
        if (hasHalfStar)
          const Icon(Icons.star_half_rounded, color: AppColors.secondary, size: 14),

        // Empty Stars
        ...List.generate(emptyStars, (index) =>
        const Icon(Icons.star_outline_rounded, color: AppColors.textLight, size: 14)),

        // Rating value text
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(fontSize: 12, color: AppColors.textMedium),
          ),
        ),
      ],
    );
  }
}