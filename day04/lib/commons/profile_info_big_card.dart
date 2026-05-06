import 'package:day04/styleguide/text_style.dart';
import 'package:flutter/material.dart';

class ProfileInfoBigCard extends StatelessWidget {
  final String firstText, secondText;
  final Widget icon;

  const ProfileInfoBigCard({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          top: 8,
          right: 16,
          bottom: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(alignment: Alignment.topRight, child: icon),
            Text(firstText, style: titleStyle),
            Text(secondText, style: subTitleStyle),
          ],
        ),
      ),
    );
  }
}
