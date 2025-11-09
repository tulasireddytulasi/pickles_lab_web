import 'package:flutter/material.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_colors.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_theme.dart';

import 'recent_customers_list.dart';
import 'top_products_list.dart';

class ProductsCustomersList extends StatefulWidget {
  const ProductsCustomersList({super.key});

  @override
  State<ProductsCustomersList> createState() => _ProductsCustomersListState();
}

class _ProductsCustomersListState extends State<ProductsCustomersList> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // Desktop breakpoint is > 768px
      final isDesktop = constraints.maxWidth >= AppBreakpoints.desktop;

      return isDesktop
          ? Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Products (1/2 width)
          const Expanded(child: TopProductsList()),
          const SizedBox(width: 16.0),
          // Recent Customers Placeholder (1/2 width)
          // Expanded(
          //   child: const RecentCustomersList(),
          // ),
        ],
      )
          : Column(
        children: [
          const TopProductsList(),
          const SizedBox(height: 16.0),
          const RecentCustomersList(),
        ],
      );
    },);
  }
}
