import 'package:flutter/material.dart';
import 'package:pickles_lab_dashboard/app/core/constants/app_keys.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_colors.dart';
import 'package:pickles_lab_dashboard/app/core/utils/app_log.dart';
import 'package:pickles_lab_dashboard/app/widgets/date_range_selector.dart';
import 'package:pickles_lab_dashboard/app/widgets/elevated_icon_button.dart';

/// The header section of the dashboard containing the title, date range selector,
/// and the export button.
///
/// This is a [StatefulWidget] to manage the state of the dropdown selection.
class DashboardHeader extends StatefulWidget {
  const DashboardHeader({super.key});

  @override
  State<DashboardHeader> createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends State<DashboardHeader> {
  String _dateRange = 'Last 7 Days';
  final List<String> _dateRangeOptions = ['Today', 'Yesterday', 'Last 7 Days', 'Last 30 Days', 'Custom Range'];

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
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: headerWidget(isMobile: isMobile),
                ),
              ),

              // Action Row (Dropdown + Export Button)
              Expanded(
                child: layoutBuilder(
                  isMobile: isMobile,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
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
        bool isHorizontal = constraints.maxWidth <= 285;
        return isHorizontal
            ? Column(
                crossAxisAlignment: crossAxisAlignment,
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
      Text('Dashboard Overview', style: Theme.of(context).textTheme.headlineLarge),

      const SizedBox(height: 4.0),

      // Subtitle/Welcome
      Text(
        'Welcome back, Admin. Here is an overview of your Pickles sales.',
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
        key: AppKeys.dashboardDropDown,
        semanticsLabel: "Select a date range for the dashboard",
        onDateRangeChanged: (String selectedRange) {
          _dateRange = selectedRange;
        },
        initialValue: _dateRange,
        options: _dateRangeOptions,
      ),

      // Vertical spacing for mobile
      isMobile ? const SizedBox(height: 8.0) : const SizedBox(width: 8.0),

      // Export Button
      ElevatedIconButton(
        label: "Export",
        semanticsLabel: "Export data to CSV",
        width: isMobile ? 158 : 118,
        icon: const Icon(Icons.file_download_outlined, size: 20, color: AppColors.cardBackground),
        onExportTapped: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Exporting data...')));
        },
      ),
    ];
  }
}
