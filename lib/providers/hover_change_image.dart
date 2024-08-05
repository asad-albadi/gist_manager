import 'package:flutter/material.dart';

class HoverChangeImage extends StatefulWidget {
  final String assetImageUrl;
  final String networkImageUrl;

  HoverChangeImage({
    required this.assetImageUrl,
    required this.networkImageUrl,
  });

  @override
  _HoverChangeImageState createState() => _HoverChangeImageState();
}

class _HoverChangeImageState extends State<HoverChangeImage> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovering = false;
        });
      },
      child: CircleAvatar(
        backgroundImage: !isHovering
            ? NetworkImage(widget.networkImageUrl)
            : AssetImage(
                widget.assetImageUrl,
              ) as ImageProvider,
      ),
    );
  }
}
