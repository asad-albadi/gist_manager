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
    backgroundColor: Color(0xFF44475A),
    foregroundColor: Color(0xFFF8F8F2),
  ),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF6272A4), // Comment color for less emphasis
    secondary: Color(0xFFFF79C6), // Pink for accents
    surface: Color(0xFF44475A), // Current line and selections
    background: Color(0xFF282A36), // Main background
    onPrimary: Color(0xFFF8F8F2),
    onSecondary: Color(0xFF282A36),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFFF8F8F2)), // Foreground
    bodyMedium: TextStyle(color: Color.fromARGB(255, 200, 204, 219)), // Comment
    displayLarge: TextStyle(color: Color(0xFF50FA7B)), // Green
    titleMedium: TextStyle(color: Color(0xFF8BE9FD)), // Cyan
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xFFFF5555), // Red for buttons
    textTheme: ButtonTextTheme.primary,
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
    backgroundColor: Color(0xFFE6E6E6),
    foregroundColor: Color(0xFF282A36),
  ),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFFB6B6B6), // Comment color for less emphasis
    secondary: Color(0xFFFF69B4), // Pink for accents
    surface: Color(0xFFE6E6E6), // Current line and selections
    background: Color(0xFFF8F8F2), // Main background
    onPrimary: Color(0xFF282A36),
    onSecondary: Color(0xFFF8F8F2),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFF282A36)), // Foreground
    bodyMedium: TextStyle(color: Color(0xFFB6B6B6)), // Comment
    displayLarge: TextStyle(color: Color(0xFF3CB371)), // Green
    titleMedium: TextStyle(color: Color(0xFF00BFC2)), // Cyan
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xFFDC143C), // Red for buttons
    textTheme: ButtonTextTheme.primary,
  ),
);
