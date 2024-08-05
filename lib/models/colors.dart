import 'package:flutter/material.dart';

class DraculaPalette {
  static const Color background = Color(0xFF282A36);
  static const Color currentLine = Color(0xFF44475A);
  static const Color foreground = Color(0xFFF8F8F2);
  static const Color comment = Color(0xFF6272A4);
  static const Color cyan = Color(0xFF8BE9FD);
  static const Color green = Color(0xFF50FA7B);
  static const Color orange = Color(0xFFFFB86C);
  static const Color pink = Color(0xFFFF79C6);
  static const Color purple = Color(0xFFBD93F9);
  static const Color red = Color(0xFFFF5555);
  static const Color yellow = Color(0xFFF1FA8C);
}

class LightDraculaPalette {
  static const Color background = Color(0xFFF8F8F2);
  static const Color currentLine = Color(0xFFE6E6E6);
  static const Color foreground = Color(0xFF282A36);
  static const Color comment = Color(0xFFB6B6B6);
  static const Color cyan = Color(0xFF00BFC2);
  static const Color green = Color(0xFF3CB371);
  static const Color orange = Color(0xFFFFA500);
  static const Color pink = Color(0xFFFF69B4);
  static const Color purple = Color(0xFF9370DB);
  static const Color red = Color(0xFFDC143C);
  static const Color yellow = Color(0xFFFFD700);
}

final ThemeData darkTheme = ThemeData(
  cardTheme: const CardTheme(elevation: 0),
  brightness: Brightness.dark,
  navigationRailTheme: const NavigationRailThemeData(
    elevation: 0,
  ),
  scaffoldBackgroundColor: DraculaPalette.background,
  appBarTheme: const AppBarTheme(
    backgroundColor: DraculaPalette.currentLine,
    foregroundColor: DraculaPalette.foreground,
  ),
  colorScheme: const ColorScheme.dark(
    primary: DraculaPalette.comment,
    secondary: DraculaPalette.pink,
    surface: DraculaPalette.currentLine,
    background: DraculaPalette.background,
    onPrimary: DraculaPalette.foreground,
    onSecondary: DraculaPalette.background,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: DraculaPalette.foreground),
    bodyMedium: TextStyle(color: DraculaPalette.foreground),
    displayLarge: TextStyle(color: DraculaPalette.green),
    titleMedium: TextStyle(color: DraculaPalette.cyan),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: DraculaPalette.red,
    textTheme: ButtonTextTheme.normal,
  ),
);

final ThemeData lightTheme = ThemeData(
  cardTheme: const CardTheme(elevation: 0),
  brightness: Brightness.light,
  navigationRailTheme: const NavigationRailThemeData(
    elevation: 0,
  ),
  scaffoldBackgroundColor: LightDraculaPalette.background,
  appBarTheme: const AppBarTheme(
    backgroundColor: LightDraculaPalette.currentLine,
    foregroundColor: LightDraculaPalette.foreground,
  ),
  colorScheme: const ColorScheme.light(
    primary: LightDraculaPalette.comment,
    secondary: LightDraculaPalette.pink,
    surface: LightDraculaPalette.currentLine,
    background: LightDraculaPalette.background,
    onPrimary: LightDraculaPalette.foreground,
    onSecondary: LightDraculaPalette.background,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: LightDraculaPalette.foreground),
    bodyMedium: TextStyle(color: LightDraculaPalette.foreground),
    displayLarge: TextStyle(color: LightDraculaPalette.green),
    titleMedium: TextStyle(color: LightDraculaPalette.cyan),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: LightDraculaPalette.red,
    textTheme: ButtonTextTheme.primary,
  ),
);
