import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:day02/model/event.dart';

class EventDetailBackground extends StatelessWidget {
  const EventDetailBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final event = Provider.of<Event>(context);
    return ClipPath(
      clipper: ImageClipper(),
      child: Image(
        image: AssetImage(event.imagePath),
        width: screenWidth,
        color: Color(0x99000000),
        colorBlendMode: BlendMode.darken,
        height: screenHeight * 0.5,
        fit: BoxFit.cover,
      ),
    );
  }
}

class ImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    Offset curveStartPoint = Offset(0, size.height * 0.1);
    Offset curveEndPoint = Offset(size.width, size.height * 0.95);
    path.lineTo(curveStartPoint.dx, curveStartPoint.dy - 5);
    path.quadraticBezierTo(
      size.width * 0.2,
      size.height * 0.85,
      curveEndPoint.dx - 60,
      curveEndPoint.dy + 5,
    );
    path.quadraticBezierTo(
      size.width * 0.99,
      size.height * 0.99,
      curveEndPoint.dx,
      curveEndPoint.dy,
    );
    path.lineTo(curveEndPoint.dx, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
