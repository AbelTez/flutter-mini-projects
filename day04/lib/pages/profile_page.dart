import 'dart:ffi';

import 'package:day04/commons/opaque_image.dart';
import 'package:day04/styleguide/colors.dart';
import 'package:day04/styleguide/text_style.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    OpaqueImage(imageUrl: "assets/images/guest1.jpg"),
                    Container(color: primaryColorOpacity.withOpacity(0.85)),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "My Profile",
                              textAlign: TextAlign.left,
                              style: headingTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(flex: 5, child: Container(color: secondaryTextColor)),
            ],
          ),
        ],
      ),
    );
  }
}
