import 'package:flutter/material.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_colors.dart';
import 'package:pickles_lab_dashboard/app/core/utils/app_log.dart';

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
      // Date Range Selector (Dropdown)
      _buildDateRangeSelector(context, isMobile),

      // Vertical spacing for mobile
      isMobile ? const SizedBox(height: 8.0) : const SizedBox(width: 8.0),

      // Export Button
      _buildExportButton(context, isMobile ? 158 : 118),
    ];
  }

  /// Builds the custom-styled dropdown for the date range.
  Widget _buildDateRangeSelector(BuildContext context, bool isMobile) {
    return SizedBox(
      width: 158,
      child: Semantics(
        label: 'Select date range',
        child: DropdownButtonFormField<String>(
          initialValue: _dateRange,
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _dateRange = newValue;
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Date range set to: $_dateRange')));
            }
          },
          items: _dateRangeOptions.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: Theme.of(context).textTheme.bodyMedium),
            );
          }).toList(),
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.only(left: 10, right: 0, top: 8, bottom: 8),
            hintText: 'Select Range',
            fillColor: AppColors.cardBackground,
            // Override Input Theme to match HTML (bg-white)
            filled: true,
          ),
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textMedium),
        ),
      ),
    );
  }

  /// Builds the primary "Export" button.
  Widget _buildExportButton(BuildContext context, double width) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        //  border: Border.all(color: Colors.black, width: 2),
      ),
      child: Semantics(
        button: true,
        label: 'Export data to CSV',
        child: ElevatedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Exporting data...')));
          },
          icon: const Icon(Icons.file_download_outlined, size: 20, color: AppColors.cardBackground),
          label: Text(
            'Export',
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(color: AppColors.cardBackground, fontWeight: FontWeight.w600),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
        ),
      ),
    );
  }
}
