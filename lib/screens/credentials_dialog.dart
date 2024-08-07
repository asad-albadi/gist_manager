import 'package:flutter/material.dart';
import 'package:gist_manager/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../providers/gist_provider.dart';

class CredentialsDialog extends StatefulWidget {
  const CredentialsDialog({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CredentialsDialogState createState() => _CredentialsDialogState();
}

class _CredentialsDialogState extends State<CredentialsDialog> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController tokenController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
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
          const SizedBox(height: 8),
          const Text(
            'To create a personal access token (classic), go to GitHub settings, navigate to Developer settings, '
            'and create a new token with gist permissions.',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
      actions: [
        _isLoading
            ? const CircularProgressIndicator()
            : TextButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });

                  await Provider.of<GistProvider>(context, listen: false)
                      .saveCredentials(
                    usernameController.text,
                    tokenController.text,
                  );
                  if (usernameController.text.isNotEmpty ||
                      tokenController.text.isNotEmpty) {
                    // ignore: use_build_context_synchronously
                    await Provider.of<GistProvider>(context, listen: false)
                        .fetchGists();
                    // ignore: use_build_context_synchronously
                    await Provider.of<UserProvider>(context, listen: false)
                        .fetchUserProfile(); // Fetch user profile
                  }

                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();

                  setState(() {
                    _isLoading = false;
                  });
                },
                child: const Text('Save'),
              ),
      ],
    );
  }
}
