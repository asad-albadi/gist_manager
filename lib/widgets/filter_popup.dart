import 'package:flutter/material.dart';

class FilterPopup extends StatelessWidget {
  final String currentVisibilityFilter;
  final String currentStarFilter;
  final Function(String) onVisibilityFilterChanged;
  final Function(String) onStarFilterChanged;

  const FilterPopup({
    super.key,
    required this.currentVisibilityFilter,
    required this.currentStarFilter,
    required this.onVisibilityFilterChanged,
    required this.onStarFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter Gists'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Visibility'),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ChoiceChip(
                  label: const Text('All'),
                  selected: currentVisibilityFilter == 'All',
                  onSelected: (selected) {
                    if (selected) {
                      onVisibilityFilterChanged('All');
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ChoiceChip(
                  label: const Text('Public'),
                  selected: currentVisibilityFilter == 'Public',
                  onSelected: (selected) {
                    if (selected) {
                      onVisibilityFilterChanged('Public');
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ChoiceChip(
                  label: const Text('Secret'),
                  selected: currentVisibilityFilter == 'Secret',
                  onSelected: (selected) {
                    if (selected) {
                      onVisibilityFilterChanged('Secret');
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Star Status'),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ChoiceChip(
                  label: const Text('All'),
                  selected: currentStarFilter == 'All',
                  onSelected: (selected) {
                    if (selected) {
                      onStarFilterChanged('All');
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ChoiceChip(
                  label: const Text('Starred'),
                  selected: currentStarFilter == 'Starred',
                  onSelected: (selected) {
                    if (selected) {
                      onStarFilterChanged('Starred');
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ChoiceChip(
                  label: const Text('Unstarred'),
                  selected: currentStarFilter == 'Unstarred',
                  onSelected: (selected) {
                    if (selected) {
                      onStarFilterChanged('Unstarred');
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
