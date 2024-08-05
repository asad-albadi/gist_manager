import 'package:gist_manager/providers/gist_provider.dart';
import 'package:gist_manager/models/colors.dart';
import 'package:gist_manager/providers/settings_provider.dart';
import 'package:gist_manager/providers/user_provider.dart';
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
        ChangeNotifierProvider(
            create: (_) => UserProvider()), // Add UserProvider
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settings, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Gist Manager",
            theme: settings.isDarkMode ? darkTheme : lightTheme,
            home: const GistListScreen(),
          );
        },
      ),
    );
  }
}
