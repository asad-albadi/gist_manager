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

const Map<String, TextStyle> darkThemeMap = {
  'root': TextStyle(
      backgroundColor: DraculaPalette.background,
      color: DraculaPalette.foreground),
  'keyword': TextStyle(color: DraculaPalette.pink, fontWeight: FontWeight.bold),
  'built_in': TextStyle(color: DraculaPalette.cyan),
  'type': TextStyle(color: DraculaPalette.orange),
  'literal': TextStyle(color: DraculaPalette.cyan),
  'number': TextStyle(color: DraculaPalette.purple),
  'operator': TextStyle(color: DraculaPalette.pink),
  'punctuation': TextStyle(color: DraculaPalette.foreground),
  'selector-id': TextStyle(color: DraculaPalette.pink),
  'selector-class': TextStyle(color: DraculaPalette.pink),
  'variable': TextStyle(color: DraculaPalette.red),
  'template-variable': TextStyle(color: DraculaPalette.red),
  'string': TextStyle(color: DraculaPalette.yellow),
  'comment': TextStyle(color: DraculaPalette.comment),
  'doctag': TextStyle(color: DraculaPalette.comment),
  'meta': TextStyle(color: DraculaPalette.orange),
  'attr': TextStyle(color: DraculaPalette.green),
  'attribute': TextStyle(color: DraculaPalette.green),
  'namespace': TextStyle(color: DraculaPalette.cyan),
  'params': TextStyle(color: DraculaPalette.orange),
  'tag': TextStyle(color: DraculaPalette.pink),
  'name': TextStyle(color: DraculaPalette.pink),
  'builtin-name': TextStyle(color: DraculaPalette.orange),
  'type-name': TextStyle(color: DraculaPalette.pink),
  'attr-name': TextStyle(color: DraculaPalette.green),
  'property': TextStyle(color: DraculaPalette.green),
  'class title':
      TextStyle(color: DraculaPalette.pink, fontWeight: FontWeight.bold),
  'title': TextStyle(color: DraculaPalette.pink, fontWeight: FontWeight.bold),
  'section': TextStyle(color: DraculaPalette.pink, fontWeight: FontWeight.bold),
  'subsection':
      TextStyle(color: DraculaPalette.pink, fontWeight: FontWeight.bold),
  'bullet': TextStyle(color: DraculaPalette.yellow),
  'emphasis': TextStyle(fontStyle: FontStyle.italic),
  'strong': TextStyle(fontWeight: FontWeight.bold),
  'formula': TextStyle(color: DraculaPalette.pink),
  'link': TextStyle(color: DraculaPalette.cyan),
  'quote': TextStyle(color: DraculaPalette.comment),
  'blockquote': TextStyle(color: DraculaPalette.comment),
  'deletion': TextStyle(color: DraculaPalette.red),
  'addition': TextStyle(color: DraculaPalette.green),
};

const Map<String, TextStyle> lightThemeMap = {
  'root': TextStyle(
      backgroundColor: LightDraculaPalette.background,
      color: LightDraculaPalette.foreground),
  'keyword':
      TextStyle(color: LightDraculaPalette.pink, fontWeight: FontWeight.bold),
  'built_in': TextStyle(color: LightDraculaPalette.cyan),
  'type': TextStyle(color: LightDraculaPalette.orange),
  'literal': TextStyle(color: LightDraculaPalette.cyan),
  'number': TextStyle(color: LightDraculaPalette.purple),
  'operator': TextStyle(color: LightDraculaPalette.pink),
  'punctuation': TextStyle(color: LightDraculaPalette.foreground),
  'selector-id': TextStyle(color: LightDraculaPalette.pink),
  'selector-class': TextStyle(color: LightDraculaPalette.pink),
  'variable': TextStyle(color: LightDraculaPalette.red),
  'template-variable': TextStyle(color: LightDraculaPalette.red),
  'string': TextStyle(color: LightDraculaPalette.yellow),
  'comment': TextStyle(color: LightDraculaPalette.comment),
  'doctag': TextStyle(color: LightDraculaPalette.comment),
  'meta': TextStyle(color: LightDraculaPalette.orange),
  'attr': TextStyle(color: LightDraculaPalette.green),
  'attribute': TextStyle(color: LightDraculaPalette.green),
  'namespace': TextStyle(color: LightDraculaPalette.cyan),
  'params': TextStyle(color: LightDraculaPalette.orange),
  'tag': TextStyle(color: LightDraculaPalette.pink),
  'name': TextStyle(color: LightDraculaPalette.pink),
  'builtin-name': TextStyle(color: LightDraculaPalette.orange),
  'type-name': TextStyle(color: LightDraculaPalette.pink),
  'attr-name': TextStyle(color: LightDraculaPalette.green),
  'property': TextStyle(color: LightDraculaPalette.green),
  'class title':
      TextStyle(color: LightDraculaPalette.pink, fontWeight: FontWeight.bold),
  'title':
      TextStyle(color: LightDraculaPalette.pink, fontWeight: FontWeight.bold),
  'section':
      TextStyle(color: LightDraculaPalette.pink, fontWeight: FontWeight.bold),
  'subsection':
      TextStyle(color: LightDraculaPalette.pink, fontWeight: FontWeight.bold),
  'bullet': TextStyle(color: LightDraculaPalette.yellow),
  'emphasis': TextStyle(fontStyle: FontStyle.italic),
  'strong': TextStyle(fontWeight: FontWeight.bold),
  'formula': TextStyle(color: LightDraculaPalette.pink),
  'link': TextStyle(color: LightDraculaPalette.cyan),
  'quote': TextStyle(color: LightDraculaPalette.comment),
  'blockquote': TextStyle(color: LightDraculaPalette.comment),
  'deletion': TextStyle(color: LightDraculaPalette.red),
  'addition': TextStyle(color: LightDraculaPalette.green),
};

final ThemeData darkTheme = ThemeData(
  cardTheme: const CardTheme(elevation: 10),
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
  cardTheme: const CardTheme(elevation: 10),
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
