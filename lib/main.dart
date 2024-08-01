import 'package:_mobile_app_to_lookup_and_search_gists/gist_provider.dart';
import 'package:_mobile_app_to_lookup_and_search_gists/models/colors.dart';
import 'package:_mobile_app_to_lookup_and_search_gists/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/gist_list_screen.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

Future<void> launchURL(url) async {
  if (!await launchUrl(Uri.parse(url))) {}
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GistProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settings, _) {
          return MaterialApp(
            theme: settings.isDarkMode ? darkTheme : lightTheme,
            home: GistListScreen(),
          );
        },
      ),
    );
  }
}
