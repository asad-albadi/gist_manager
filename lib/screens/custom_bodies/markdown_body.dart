import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/services.dart';
import 'package:gist_manager/models/gist_model.dart';
import 'package:markdown/markdown.dart' as md;

class CustomMarkdownBody extends StatelessWidget {
  final Gist gist;

  const CustomMarkdownBody({super.key, required this.gist});

  @override
  Widget build(BuildContext context) {
    return Markdown(
      data: gist.content,
      selectable: true,
      styleSheet: MarkdownStyleSheet(
        code: TextStyle(
          backgroundColor: Theme.of(context).colorScheme.background,
          fontFamily: 'monospace',
          fontSize: 14.0,
        ),
        codeblockPadding: const EdgeInsets.all(8.0),
        codeblockDecoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            color: Colors.transparent,
          ),
        ),
      ),
      imageBuilder: (uri, title, alt) {
        return Image.network(
          uri.toString(),
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error);
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        (loadingProgress.expectedTotalBytes ?? 1)
                    : null,
              ),
            );
          },
        );
      },
      builders: {
        'code': CodeElementBuilder(context),
      },
    );
  }
}

class CodeElementBuilder extends MarkdownElementBuilder {
  final BuildContext context;

  CodeElementBuilder(this.context);

  @override
  Widget visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    return (element.attributes['class'] ?? "-").toString().split('-')[1] == ""
        ? Text(
            element.textContent,
          )
        : Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.primary),
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.5),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                          border: Border.all(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SelectableText(
                              (element.attributes['class'] ?? "-")
                                  .toString()
                                  .split('-')[1],
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 12.0,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.copy, size: 16.0),
                              onPressed: () {
                                Clipboard.setData(
                                    ClipboardData(text: element.textContent));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: SelectableText(
                                        'Code copied to clipboard',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground),
                                      ),
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .background),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SelectableText(
                            element.textContent,
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
