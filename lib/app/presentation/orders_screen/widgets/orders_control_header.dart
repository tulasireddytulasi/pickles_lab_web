import 'package:flutter/material.dart';
import 'package:pickles_lab_dashboard/app/core/constants/app_keys.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_colors.dart';
import 'package:pickles_lab_dashboard/app/core/utils/app_log.dart';
import 'package:pickles_lab_dashboard/app/widgets/date_range_selector.dart';
import 'package:pickles_lab_dashboard/app/widgets/elevated_icon_button.dart';
import 'package:pickles_lab_dashboard/app/widgets/outlined_button_icon.dart';

/// The header section of the Orders containing the title, date range selector,
/// and the export button.
///
/// This is a [StatefulWidget] to manage the state of the dropdown selection.
class OrdersHeader extends StatefulWidget {
  const OrdersHeader({super.key});

  @override
  State<OrdersHeader> createState() => _OrdersHeaderState();
}

class _OrdersHeaderState extends State<OrdersHeader> {
  String _dateRange1 = 'Last 7 Days';
  final List<String> _dateRangeOptions1 = ['Today', 'Yesterday', 'Last 7 Days', 'Last 30 Days', 'Custom Range'];

  @override
  Widget build(BuildContext context) {
    // Check screen width for responsiveness
    final isMobile = MediaQuery.of(context).size.width < 769;
    AppLog.info("Size: ${MediaQuery.of(context).size.width}");

    return isMobile
        ? Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: headerWidget(isMobile: isMobile),
        ),
        const SizedBox(height: 16),
        layoutBuilder(isMobile: isMobile,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,),
      ],
    )
        : Row(
     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: headerWidget(isMobile: isMobile),
        ),

        // Action Row (Dropdown + Export Button)
        Expanded(
          child: Container(
            alignment: Alignment.topRight,
            decoration: BoxDecoration(
             // border: Border.all(color: Colors.black, width: 2),
            ),
            child: layoutBuilder(
              isMobile: isMobile,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
            ),
          ),
        ),
      ],
    );
  }

  LayoutBuilder layoutBuilder({
    required bool isMobile,
    required MainAxisAlignment mainAxisAlignment,
    required CrossAxisAlignment crossAxisAlignment,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        AppLog.info("constraints : ${constraints.maxWidth}");
        bool isHorizontal = constraints.maxWidth <= 416;
        return isHorizontal
            ? Wrap(
         // crossAxisAlignment: crossAxisAlignment,
          spacing: 6,
          runSpacing: 6,
          children: actionRowWidget(isMobile: isHorizontal),
        )
            : Row(
          mainAxisAlignment: mainAxisAlignment,
          children: actionRowWidget(isMobile: isHorizontal),
        );
      },
    );
  }

  List<Widget> headerWidget({required bool isMobile}) {
    return [
      Text('Orders', style: Theme.of(context).textTheme.headlineLarge),

      const SizedBox(height: 4.0),

      // Subtitle/Welcome
      Text(
        'Manage and track all your food orders',
        maxLines: 3,
        softWrap: true,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(color: AppColors.textMedium, overflow: TextOverflow.ellipsis),
      ),
    ];
  }

  List<Widget> actionRowWidget({required bool isMobile}) {
    return [
      /// Builds the custom-styled dropdown for the date range.
      DateRangeSelector(
        key: AppKeys.ordersDropDown,
        semanticsLabel: "Select date range for orders",
        onDateRangeChanged: (String selectedRange) {
          _dateRange1 = selectedRange;
        },
        initialValue: _dateRange1,
        options: _dateRangeOptions1,
      ),

      // Vertical spacing for mobile
      isMobile ? const SizedBox(height: 8.0) : const SizedBox(width: 8.0),


      OutlinedButtonIcon(
        label: "Export",
        semanticsLabel: "Export data to CSV",
       // width: isMobile ? 158 : 118,
        onExportTapped: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Exporting data...')));
        },
      ),

      isMobile ? const SizedBox(height: 8.0) : const SizedBox(width: 8.0),


      // Export Button
      ElevatedIconButton(
        label: "New Order",
        semanticsLabel: "New Order",
        width: isMobile ? 158 : 138,
        labelStyle: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(
    color: AppColors.cardBackground,
    fontWeight: FontWeight.w600,
    ),
        buttonStyle: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.cardBackground,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
        icon: const Icon(Icons.add, size: 20, color: AppColors.cardBackground),
        onExportTapped: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('New Order...')));
        },
      ),
    ];
  }
}
