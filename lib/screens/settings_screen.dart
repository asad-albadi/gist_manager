import 'package:_mobile_app_to_lookup_and_search_gists/screens/settings_dialog.dart';
import 'package:_mobile_app_to_lookup_and_search_gists/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<SettingsProvider>(
              builder: (context, settingsProvider, child) {
                return SwitchListTile(
                  title: Text('Dark Mode'),
                  value: settingsProvider.isDarkMode,
                  onChanged: (value) {
                    settingsProvider.toggleTheme();
                  },
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => SettingsDialog(),
                );
              },
              child: Text('Update Credentials'),
            ),
          ],
        ),
      ),
    );
  }
}
