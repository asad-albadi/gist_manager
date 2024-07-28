import 'package:_mobile_app_to_lookup_and_search_gists/models/gist_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class GistDetailScreen extends StatelessWidget {
  final Gist gist;

  GistDetailScreen({required this.gist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(gist.filename)),
      body: Markdown(data: gist.content),
    );
  }
}
