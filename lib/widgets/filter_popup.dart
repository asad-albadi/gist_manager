// filter_popup.dart

import 'package:flutter/material.dart';

class FilterPopup extends StatelessWidget {
  final String currentFilter;
  final Function(String) onFilterChanged;

  FilterPopup({required this.currentFilter, required this.onFilterChanged});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter Gists'),
      content: Wrap(
        alignment: WrapAlignment.spaceAround,
        children: [
          ChoiceChip(
            label: const Text('All'),
            selected: currentFilter == 'All',
            onSelected: (selected) {
              if (selected) {
                onFilterChanged('All');
                Navigator.of(context).pop();
              }
            },
          ),
          ChoiceChip(
            label: const Text('Public'),
            selected: currentFilter == 'Public',
            onSelected: (selected) {
              if (selected) {
                onFilterChanged('Public');
                Navigator.of(context).pop();
              }
            },
          ),
          ChoiceChip(
            label: const Text('Secret'),
            selected: currentFilter == 'Secret',
            onSelected: (selected) {
              if (selected) {
                onFilterChanged('Secret');
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
