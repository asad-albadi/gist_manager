// settings_dialog.dart

import 'package:_mobile_app_to_lookup_and_search_gists/screens/credentials_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:_mobile_app_to_lookup_and_search_gists/providers/settings_provider.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Settings', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          Consumer<SettingsProvider>(
            builder: (context, settingsProvider, child) {
              return SwitchListTile(
                title: const Text('Dark Mode'),
                value: settingsProvider.isDarkMode,
                onChanged: (value) {
                  settingsProvider.toggleTheme();
                },
              );
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const CredentialsDialog(),
              );
            },
            child: const Text('Update Credentials'),
          ),
        ],
      ),
    );
  }
}
