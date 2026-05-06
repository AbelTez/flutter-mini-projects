import 'package:flutter/material.dart';

class OpaqueImage extends StatelessWidget {
  final imageUrl;
  const OpaqueImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imageUrl,
      fit: BoxFit.fill,
      width: double.maxFinite,
      height: double.maxFinite,
    );
  }
}
