import 'package:flutter/material.dart';
import 'package:gist_manager/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../providers/gist_provider.dart';

class CredentialsDialog extends StatefulWidget {
  const CredentialsDialog({super.key});

  @override
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
                    await Provider.of<GistProvider>(context, listen: false)
                        .fetchGists();
                    await Provider.of<UserProvider>(context, listen: false)
                        .fetchUserProfile(); // Fetch user profile
                  }

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
