import 'package:day04/commons/rounded_image.dart';
import 'package:flutter/material.dart';
import '../model/super_liked_me.dart';

class SuperLikedMeCard extends StatelessWidget {
  const SuperLikedMeCard({super.key, required this.user});

  final SuperLikedMe user;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            RoundedImage(imagePath: user.imageUrl, size: Size.fromWidth(30.0)),
            SizedBox(width: 6.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.grey,
                      size: 16.0,
                    ),
                    Text(
                      user.location,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: user.isActive ? Colors.green : Colors.grey,
                      size: 12.0,
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      user.isActive ? "Online" : "Offline",
                      style: TextStyle(
                        fontSize: 12,
                        color: user.isActive ? Colors.green : Colors.grey,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.star, color: Colors.blue, size: 20.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
