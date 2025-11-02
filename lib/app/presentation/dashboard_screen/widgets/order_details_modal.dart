// lib/screens/dashboard/widgets/order_details_modal.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_colors.dart';
import 'package:pickles_lab_dashboard/app/data/mock_data/metric_mock_data.dart';
import 'data_display/status_badge.dart';

/// Helper function to show the OrderDetailsModal
void showOrderDetailsModal({required BuildContext context, required String orderId}) {
  showDialog(
    context: context,
    builder: (context) => OrderDetailsModal(orderId: orderId),
  );
}

/// The modal dialog that displays the full details of a specific order.
class OrderDetailsModal extends StatefulWidget {
  final String orderId;

  const OrderDetailsModal({super.key, required this.orderId});

  @override
  State<OrderDetailsModal> createState() => _OrderDetailsModalState();
}

class _OrderDetailsModalState extends State<OrderDetailsModal> {
  late DetailedOrder _detailedOrder;
  final currencyFormatter = NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 2);

  @override
  void initState() {
    super.initState();
    // Fetch the detailed mock data based on the ID
    _detailedOrder = MockDataService().getDetailedOrder(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    // Uses Dialog to create a modal overlay. Constrained for large screens.
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width > 800 ? 800 : double.infinity,
          constraints: const BoxConstraints(maxHeight: 700),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: [
              // --- Modal Header ---
              _buildModalHeader(context),

              // --- Modal Body (Scrollable) ---
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildOrderStatusSection(),
                      const SizedBox(height: 32),
                      _buildOrderItemsSection(context),
                      const SizedBox(height: 32),
                      _buildCustomerAndShippingSection(context),
                      const SizedBox(height: 32),
                      _buildPaymentAndSummarySection(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModalHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 24, 16, 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Order Details: ${_detailedOrder.baseOrder.id}',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.textMedium),
            onPressed: () => Navigator.of(context).pop(),
            tooltip: 'Close details',
          ),
        ],
      ),
    );
  }

  Widget _buildOrderStatusSection() {
    // Displays Date and Status
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order Date', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 4),
            Text(
              DateFormat('MMM d, yyyy - h:mm a').format(_detailedOrder.baseOrder.orderDate),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('Status', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 4),
            StatusBadge(status: _detailedOrder.baseOrder.status),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(title, style: Theme.of(context).textTheme.titleLarge),
    );
  }

  Widget _buildOrderItemsSection(BuildContext context) {
    // Displays a list of products in the order
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Order Items (${_detailedOrder.items.length})'),
        ..._detailedOrder.items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 64, height: 64, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(8)),
                    margin: const EdgeInsets.only(right: 16),
                    child: const Center(child: Icon(Icons.image_outlined, size: 30, color: AppColors.textLight)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.productName, style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 4),
                      Text('Quantity: ${item.quantity}', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.textMedium)),
                    ],
                  ),
                ],
              ),
              Text(
                currencyFormatter.format(item.totalPrice),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildCustomerAndShippingSection(BuildContext context) {
    // Displays customer and address details
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Customer & Shipping'),
        _buildDetailRow('Customer Name', _detailedOrder.baseOrder.customerName),
        _buildDetailRow('Email', _detailedOrder.customerEmail),
        _buildDetailRow('Shipping Address', _detailedOrder.shippingAddress, isLast: true),
      ],
    );
  }

  Widget _buildPaymentAndSummarySection(BuildContext context) {
    // Displays payment method and total cost breakdown
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Payment & Summary'),
        _buildDetailRow('Payment Method', _detailedOrder.paymentMethod),
        const Divider(height: 24, color: AppColors.border),
        _buildSummaryRow(context, 'Subtotal', _detailedOrder.subtotal),
        _buildSummaryRow(context, 'Shipping Fee', _detailedOrder.shippingFee),
        const SizedBox(height: 8),
        _buildSummaryRow(context, 'Total Amount', _detailedOrder.totalAmount, isTotal: true),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.textMedium)),
          const SizedBox(width: 16),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(BuildContext context, String label, double amount, {bool isTotal = false}) {
    final textStyle = isTotal
        ? Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700)
        : Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: textStyle),
          Text(
            currencyFormatter.format(amount),
            style: textStyle,
          ),
        ],
      ),
    );
  }
}