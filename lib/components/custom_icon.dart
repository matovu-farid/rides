import 'package:flutter/material.dart';

class CustomIcon extends StatefulWidget {
  final String assetPath;
  final double size;

  CustomIcon({required this.assetPath, this.size = 24.0});

  @override
  _CustomIconState createState() => _CustomIconState();
}

class _CustomIconState extends State<CustomIcon> {
  late Image _iconImage;

  @override
  void initState() {
    super.initState();
    _iconImage = Image.asset(
      widget.assetPath,
      width: widget.size,
      height: widget.size,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _iconImage;
  }
}
