import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class RadialProgress extends StatefulWidget {
  final double goalCompleted;
  final Widget child;
  final Color progressColor;
  final Color progressBackgroundColor;
  final double width;
  const RadialProgress({
    super.key,
    required this.child,
    this.goalCompleted = 0.7,
    this.progressColor = Colors.white,
    this.progressBackgroundColor = Colors.white,
    this.width = 8.0,
  });

  @override
  State<RadialProgress> createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  AnimationController? _radialProgressAnimationController;
  Animation<double>? _progressAnimation;
  final Duration fadeInDuration = Duration(milliseconds: 500);
  final Duration fillDuration = Duration(seconds: 2);

  double progressDegrees = 0;
  var count = 0;

  @override
  void initState() {
    super.initState();
    _radialProgressAnimationController = AnimationController(
      vsync: this,
      duration: fillDuration,
    );
    _progressAnimation =
        Tween(begin: 0.0, end: 360.0).animate(
          CurvedAnimation(
            parent: _radialProgressAnimationController!,
            curve: Curves.easeIn,
          ),
        )..addListener(() {
          setState(() {
            progressDegrees = widget.goalCompleted * _progressAnimation!.value;
          });
        });
    _radialProgressAnimationController!.forward();
  }

  @override
  void dispose() {
    _radialProgressAnimationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RadialPainter(
        progressDegrees,
        widget.progressColor,
        widget.progressBackgroundColor,
        widget.width,
      ),
      child: Padding(padding: const EdgeInsets.all(8.0), child: widget.child),
      
    );
  }
}

class RadialPainter extends CustomPainter {
  double progressInDegrees, width;
  final Color progressColor, progressBackgroundColor;

  RadialPainter(
    this.progressInDegrees,
    this.progressColor,
    this.progressBackgroundColor,
    this.width,
  );

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = progressBackgroundColor.withOpacity(0.5)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Offset Center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(Center, size.width / 2, paint);

    Paint progressPaint = Paint()
      ..color = progressColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
  
    canvas.drawArc(
      Rect.fromCircle(center: Center, radius: size.width/2), math.radians(-90), math.radians(progressInDegrees), false, progressPaint);
    
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
