import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:gist_manager/models/colors.dart';

class SyntaxHighlightedCode extends StatelessWidget {
  final String code;
  final String language;
  final TextStyle textStyle;
  final EdgeInsets padding;

  const SyntaxHighlightedCode({
    super.key,
    required this.code,
    this.language = 'python', // Default to Python if not specified
    this.textStyle = const TextStyle(
      fontFamily: 'Courier', // Use a monospace font
      fontSize: 16,
    ),
    this.padding = const EdgeInsets.all(12),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Ensures the container spans the full width
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ConstrainedBox(
          constraints:
              BoxConstraints(minWidth: MediaQuery.of(context).size.width),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: HighlightView(
              code,
              language: language,
              theme: darkThemeMap,
              padding: padding,
              textStyle: textStyle,
            ),
          ),
        ),
      ),
    );
  }
}
