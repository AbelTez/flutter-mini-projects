import 'package:day04/commons/super_liked_me_card.dart';
import 'package:day04/styleguide/text_style.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../model/super_liked_me.dart';

class SuperLikesMePage extends StatefulWidget {
  const SuperLikesMePage({super.key});

  @override
  State<SuperLikesMePage> createState() => _SuperLikesMePageState();
}

class _SuperLikesMePageState extends State<SuperLikesMePage> {
  List<SuperLikedMe> superLikedMeList = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    loadSuperLikes();
  }

  Future<void> loadSuperLikes() async {
    final String response = await rootBundle.loadString(
      "assets/data/super_liked_me.json",
    );
    final List<dynamic> data = jsonDecode(response);

    setState(() {
      superLikedMeList = data
          .map((json) => SuperLikedMe.fromJson(json))
          .toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  iconSize: 32,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  onPressed: () {
                    // Handle select button press
                  },
                  child: Text(
                    "Select",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Super Liked Me",
                style: headingTextStyle.copyWith(
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Search Friends",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Text("Super Likes", style: titleStyle),

                SizedBox(width: 10.0),

                ClipOval(
                  child: Container(
                    width: 30,
                    height: 30,
                    color: Colors.red,
                    padding: EdgeInsets.all(6.0),
                    child: Center(
                      child: Text(
                        superLikedMeList.length.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(),

                Text("1h", style: TextStyle(fontSize: 20)),
              ],
            ),

            SizedBox(height: 10),

            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: superLikedMeList.length,
                      itemBuilder: (context, index) {
                        final user = superLikedMeList[index];

                        return SuperLikedMeCard(user: user);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
