import 'package:flutter/material.dart';
import 'package:day04/commons/rounded_image.dart';

class MyInfo extends StatelessWidget {
  const MyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          RoundedImage(
            imagePath: 'assets/images/guest1.jpg',
            size: Size.fromWidth(120.0),
          ),
        ],
      ),
    );
  }
}
