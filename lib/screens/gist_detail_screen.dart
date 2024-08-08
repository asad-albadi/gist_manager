// gist_detail_screen.dart

import 'package:flutter/material.dart';

import 'package:gist_manager/main.dart';
import 'package:gist_manager/providers/gist_provider.dart';
import 'package:gist_manager/screens/custom_bodies/syntax_highlighted_code.dart';
import 'package:gist_manager/screens/edit_gist_screen.dart';
import 'package:gist_manager/screens/custom_bodies/markdown_body.dart';

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
      body: Builder(
        builder: (context) {
          if (gist.filename.endsWith('.md')) {
            return CustomMarkdownBody(
              gist: gist,
            );
          } else if (gist.filename.endsWith('.py')) {
            return SyntaxHighlightedCode(
              code: gist.content,
              language: 'python',
            );
          } else {
            return Text(
              gist.content,
            );
          }
        },
      ),
    );
  }
}
