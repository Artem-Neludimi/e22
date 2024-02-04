import 'dart:ui';

import 'package:flutter/material.dart';

Path _sbpLevel1PathJus(Size size) {
  final segment = size.width / 6;
  return Path()
    ..moveTo(0, segment * 2)
    ..lineTo(segment * 2, segment * 2)
    ..lineTo(segment * 2, segment * 3)
    ..lineTo(segment * 6, segment * 3)
    ..lineTo(segment * 6, segment * 5)
    ..lineTo(0, segment * 5)
    ..lineTo(0, segment * 2 - 1.5);
}

class _SbpLevelPainterJus extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(126, 128, 83, 38)
      ..style = PaintingStyle.fill;

    final path = _sbpLevel1PathJus(size);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_SbpLevelPainterJus oldDelegate) => false;
}

class _SbpLevelBorderPainterJus extends CustomPainter {
  const _SbpLevelBorderPainterJus(this.color);
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final path = _sbpLevel1PathJus(size);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_SbpLevelBorderPainterJus oldDelegate) => false;
}

class SbpLevel1ClipperJus extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = _sbpLevel1PathJus(size);
    return path;
  }

  @override
  bool shouldReclip(SbpLevel1ClipperJus oldClipper) => false;
}

class SbpLevel1WidgetJus extends StatelessWidget {
  const SbpLevel1WidgetJus({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          height: 270,
          width: 270,
          child: ClipPath(
            clipper: SbpLevel1ClipperJus(),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: CustomPaint(
                painter: _SbpLevelPainterJus(),
              ),
            ),
          ),
        ),
        const Positioned(
          top: -1.5,
          bottom: -1.5,
          left: -1.5,
          right: -1.5,
          child: CustomPaint(
            painter: _SbpLevelBorderPainterJus(Color.fromRGBO(185, 144, 87, 1)),
          ),
        ),
      ],
    );
  }
}
