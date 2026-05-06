import 'package:day04/commons/radial_progress.dart';
import 'package:day04/styleguide/text_style.dart';
import 'package:flutter/material.dart';
import 'package:day04/commons/rounded_image.dart';

class MyInfo extends StatelessWidget {
  const MyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RadialProgress(
            goalCompleted: 0.85,
            width: 5,
            child: RoundedImage(
              imagePath: 'assets/images/guest1.jpg',
              size: Size.fromWidth(120.0),
            ),
          ),

          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Teddy Afro", style: whiteNameTextStyle),
              Text(", 32", style: whiteNameTextStyle),
            ],
          ),
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on_outlined, color: Colors.white, size: 16.0),
              Text(
                "Addis Ababa, Ethiopia",
                style: whiteNameTextStyle.copyWith(fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
