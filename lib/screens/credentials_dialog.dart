import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../gist_provider.dart';

class CredentialsDialog extends StatelessWidget {
  const CredentialsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController tokenController = TextEditingController();

    return AlertDialog(
      title: const Text('Enter GitHub Credentials'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: usernameController,
            decoration: const InputDecoration(labelText: 'Username'),
          ),
          TextField(
            controller: tokenController,
            decoration: const InputDecoration(labelText: 'Access Token'),
            obscureText: true,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Provider.of<GistProvider>(context, listen: false).saveCredentials(
              usernameController.text,
              tokenController.text,
            );
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
