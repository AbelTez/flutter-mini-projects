import 'package:day04/commons/two_line_item.dart';
import 'package:flutter/material.dart';

class ProfileInfoCard extends StatelessWidget {
  final String firstText;
  final String secondText;
  final bool hasImage;
  final String? imageUrl;

  const ProfileInfoCard({
    super.key,
    this.firstText = '',
    this.secondText = '',
    this.hasImage = false,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 12,
        child: Center(
          child: hasImage
              ? Image.asset(imageUrl!, fit: BoxFit.cover)
              : TwoLineItem(firstText: firstText, secondText: secondText),
        ),
      ),
    );
  }
}
