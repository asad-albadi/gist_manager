// create_gist_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/gist_provider.dart';

class CreateGistScreen extends StatefulWidget {
  @override
  _CreateGistScreenState createState() => _CreateGistScreenState();
}

class _CreateGistScreenState extends State<CreateGistScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _filenameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  bool _isPublic = true;
  bool _isLoading = false;

  void _createGist() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        await Provider.of<GistProvider>(context, listen: false).createGist(
          _filenameController.text,
          _descriptionController.text,
          _contentController.text,
          _isPublic,
        );
        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create gist: $e')),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Gist'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _filenameController,
                decoration: InputDecoration(labelText: 'Filename'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a filename';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(labelText: 'Content'),
                maxLines: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter content';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text('Public'),
                  Switch(
                    value: _isPublic,
                    onChanged: (value) {
                      setState(() {
                        _isPublic = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _createGist,
                      child: Text('Create Gist'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
