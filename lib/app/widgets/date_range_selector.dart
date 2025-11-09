import 'package:flutter/material.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_colors.dart';

class DateRangeSelector extends StatefulWidget {
  final Function(String) onDateRangeChanged;
  final String initialValue;
  final List<String> options;
  final String semanticsLabel;

  const DateRangeSelector({
    super.key,
    required this.onDateRangeChanged,
    this.initialValue = 'Last 7 Days',
    this.options = const ['Today', 'Yesterday', 'Last 7 Days', 'Last 30 Days', 'Custom Range'],
    required this.semanticsLabel,
  });

  @override
  State<DateRangeSelector> createState() => _DateRangeSelectorState();
}

class _DateRangeSelectorState extends State<DateRangeSelector> {
  late final ValueNotifier<String> _currentRangeNotifier;

  @override
  void initState() {
    super.initState();
    _currentRangeNotifier = ValueNotifier<String>(widget.initialValue);
  }

  @override
  void dispose() {
    _currentRangeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 158,
      child: Semantics(
        label: widget.semanticsLabel,
        child: ValueListenableBuilder<String>(
          valueListenable: _currentRangeNotifier,
          builder: (context, currentRange, child) {
            return DropdownButtonFormField<String>(
              initialValue: currentRange,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  _currentRangeNotifier.value = newValue;
                  widget.onDateRangeChanged(newValue);
                }
              },
              items: widget.options.map<DropdownMenuItem<String>>((String value) {
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
                filled: true,
              ),
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textMedium),
            );
          },
        ),
      ),
    );
  }
}
