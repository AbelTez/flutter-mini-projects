import 'package:day04/styleguide/text_style.dart';
import 'package:flutter/material.dart';

class TwoLineItem extends StatelessWidget {
  final String firstText;
  final String secondText;
  const TwoLineItem({
    super.key,
    required this.firstText,
    required this.secondText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(firstText, style: titleStyle),
        Text(secondText, style: subTitleStyle),
      ],
    );
  }
}
