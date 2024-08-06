// edit_gist_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/gist_model.dart';
import '../providers/gist_provider.dart';

class EditGistScreen extends StatefulWidget {
  final Gist gist;

  EditGistScreen({required this.gist});

  @override
  _EditGistScreenState createState() => _EditGistScreenState();
}

class _EditGistScreenState extends State<EditGistScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _filenameController;
  late TextEditingController _descriptionController;
  late TextEditingController _contentController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _filenameController = TextEditingController(text: widget.gist.filename);
    _descriptionController =
        TextEditingController(text: widget.gist.description ?? '');
    _contentController = TextEditingController(text: widget.gist.content);
  }

  @override
  void dispose() {
    _filenameController.dispose();
    _descriptionController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _editGist() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        await Provider.of<GistProvider>(context, listen: false).editGist(
          widget.gist.id,
          _filenameController.text,
          _descriptionController.text,
          _contentController.text,
        );
        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to edit gist: $e'),
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double availableHeight =
        screenHeight - 400; // Subtracting approximate height of other widgets
    final int maxLines = (availableHeight / 24)
        .floor(); // Assuming each line is about 24 pixels high

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Gist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _filenameController,
                decoration: const InputDecoration(labelText: 'Filename'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a filename';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: 'Content'),
                maxLines: maxLines,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter content';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _editGist,
                      child: const Text('Save Changes'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
