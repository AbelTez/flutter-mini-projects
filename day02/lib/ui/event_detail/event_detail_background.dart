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
        height: screenHeight * 0.5,
        fit: BoxFit.cover,
      ),
    );
  }
}

class ImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    Offset curveStartPoint = Offset(0, size.height * 0.85);
    Offset curveEndPoint = Offset(size.width, size.height * 0.85);
    path.lineTo(curveStartPoint.dx, curveStartPoint.dy);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
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
