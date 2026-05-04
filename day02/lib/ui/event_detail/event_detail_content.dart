import 'package:day02/model/event.dart';
import 'package:day02/model/guest.dart';
import 'package:day02/style_guide.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventDetailContent extends StatelessWidget {
  const EventDetailContent({super.key});

  @override
  Widget build(BuildContext context) {
    final event = Provider.of<Event>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 100),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.2),
            child: Text(event.title, style: eventWhiteTitleTextStyle),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.30),
            child: FittedBox(
              child: Row(
                children: [
                  Text(
                    "_",
                    style: eventLocationTextStyle.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(Icons.location_on, color: Colors.white),
                  SizedBox(width: 5),
                  Text(
                    event.location,
                    style: eventLocationTextStyle.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text("GUESTS", style: guestTextStyle),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final guest in guests)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ClipOval(
                          child: Image(
                            image: AssetImage(guest.imagePath),
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(guest.name, style: guestNameTextStyle),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: event.punchline1, style: punchLine1TextStyle),
                  TextSpan(text: event.punchline2, style: punchLine2TextStyle),
                ],
              ),
            ),
          ),
          if (event.description.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(event.description, style: eventDescriptionTextStyle),
            ),
          if (event.galleryImages.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0),
              child: Text("GALLERY", style: guestTextStyle),
            ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final gallery in event.galleryImages)
                  Container(
                    margin: const EdgeInsets.only(
                      left: 8.0,
                      right: 8,
                      bottom: 16.0,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image(
                        image: AssetImage(gallery),
                        width: 180,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
