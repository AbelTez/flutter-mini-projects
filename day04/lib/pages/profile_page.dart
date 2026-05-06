import 'dart:ffi';

import 'package:day04/commons/my_info.dart';
import 'package:day04/commons/opaque_image.dart';
import 'package:day04/commons/profile_info_big_card.dart';
import 'package:day04/commons/profile_info_card.dart';
import 'package:day04/pages/super_likes_me_page.dart';
import 'package:day04/styleguide/colors.dart';
import 'package:day04/styleguide/text_style.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
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
                      padding: const EdgeInsets.only(
                        top: 32.0,
                        left: 16.0,
                        right: 16.0,
                      ),
                      child: Column(
                        children: [
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_back_ios),
                                color: Colors.white,
                                onPressed: () {
                                  // Handle back button press
                                },
                              ),
                              Spacer(),
                              IconButton(
                                icon: Icon(Icons.search_outlined),
                                color: Colors.white,
                                onPressed: () {
                                  // Handle search button press
                                },
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "My Profile",
                              textAlign: TextAlign.left,
                              style: headingTextStyle.copyWith(fontSize: 25),
                            ),
                          ),
                          MyInfo(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  padding: EdgeInsets.only(top: 40.0),
                  color: Colors.white,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          ProfileInfoBigCard(
                            firstText: "13",
                            secondText: "New Matches",
                            icon: Icon(Icons.star, color: Colors.blue),
                          ),
                          ProfileInfoBigCard(
                            firstText: "16",
                            secondText: "Unmatched me",
                            icon: Icon(
                              Icons.face_retouching_off_rounded,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          ProfileInfoBigCard(
                            firstText: "256",
                            secondText: "All Matches",
                            icon: Icon(Icons.menu_open, color: Colors.blue),
                          ),
                          ProfileInfoBigCard(
                            firstText: "42",
                            secondText: "rematches",
                            icon: Icon(
                              Icons.recent_actors_outlined,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          ProfileInfoBigCard(
                            firstText: "456",
                            secondText: "Profile visitors",
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: Colors.blue,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SuperLikesMePage(),
                                ),
                              );
                            },
                            child: ProfileInfoBigCard(
                              firstText: "4002",
                              secondText: "Super Likes",
                              icon: Icon(Icons.favorite, color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: screenHeight * 0.4 + 10,
            left: 16,
            right: 16,
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ProfileInfoCard(firstText: "54%", secondText: "Progress"),
                  ProfileInfoCard(
                    hasImage: true,
                    imageUrl: "assets/images/heartwave.png",
                  ),
                  ProfileInfoCard(firstText: "152", secondText: "Level"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
