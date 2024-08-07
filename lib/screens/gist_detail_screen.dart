// gist_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gist_manager/main.dart';
import 'package:gist_manager/providers/gist_provider.dart';
import 'package:gist_manager/screens/edit_gist_screen.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:provider/provider.dart';
import '../models/gist_model.dart';

class GistDetailScreen extends StatelessWidget {
  final Gist gist;

  const GistDetailScreen({super.key, required this.gist});

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Gist'),
          content: const Text(
              'Are you sure you want to delete this gist? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // Red color for the confirmation button
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _confirmDelete(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text(
              'This is your last chance. Do you really want to delete this gist?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary:
                    Colors.red, // Red color for the final confirmation button
              ),
              onPressed: () async {
                await Provider.of<GistProvider>(context, listen: false)
                    .deleteGist(gist.id);
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Go back to the previous screen
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<GistProvider>(
          builder: (context, gistProvider, child) {
            final updatedGist = gistProvider.gists
                .firstWhere((g) => g.id == gist.id, orElse: () => gist);
            return Row(
              children: [
                Expanded(
                  child: Text(
                    updatedGist.filename,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: Icon(updatedGist.isPublic ? Icons.lock : Icons.public),
                  onPressed: () async {
                    await Provider.of<GistProvider>(context, listen: false)
                        .toggleGistVisibility(updatedGist);
                  },
                ),
                IconButton(
                  tooltip: "Click here to go to: ${updatedGist.url}",
                  icon: const Icon(Icons.link, size: 18.0),
                  onPressed: () {
                    launchURL(updatedGist.url);
                  },
                ),
                IconButton(
                  tooltip: "Edit: ${updatedGist.filename} ",
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditGistScreen(gist: updatedGist),
                      ),
                    );
                  },
                ),
                IconButton(
                  /* style: ElevatedButton.styleFrom(
                primary: Colors.red, // Red color for the delete button
              ), */
                  onPressed: () => _showDeleteConfirmation(context),
                  icon: const Icon(Icons.delete),
                ),
              ],
            );
          },
        ),
      ),
      body: Markdown(
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
      ),
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
