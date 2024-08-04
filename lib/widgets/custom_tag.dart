import 'package:flutter/material.dart';

class CustomTag extends StatelessWidget {
  final String name;
  final Color color;

  CustomTag({required this.name, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        name,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class GistItem extends StatelessWidget {
  final String filename;
  final String description;
  final String createdAt;

  GistItem({
    required this.filename,
    required this.description,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(filename),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          filename.split('.md')[0] == description
              ? const Text('')
              : Text(description),
          CustomTag(name: 'Test', color: Colors.red),
          Text(createdAt),
        ],
      ),
    );
  }
}
