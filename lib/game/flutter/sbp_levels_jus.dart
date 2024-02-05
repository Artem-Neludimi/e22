import 'dart:ui';

import 'package:flutter/material.dart';

Path _sbpLevel1PathJus(Size size) {
  final segment = size.width / 6;
  return Path()
    ..moveTo(0, segment * 2)
    ..lineTo(segment * 6, segment * 2)
    ..lineTo(segment * 6, segment * 5)
    ..lineTo(0, segment * 5);
}

Path _sbpLevel2PathJus(Size size) {
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

Path _sbpLevel3PathJus(Size size) {
  final segment = size.width / 6;
  return Path()
    ..moveTo(0, 0)
    ..lineTo(segment * 6, 0)
    ..lineTo(segment * 6, segment * 3)
    ..lineTo(segment * 6, segment * 4)
    ..lineTo(segment * 4, segment * 4)
    ..lineTo(segment * 4, segment * 6)
    ..lineTo(0, segment * 6)
    ..lineTo(0, 0);
}

class _SbpLevelPainterJus extends CustomPainter {
  const _SbpLevelPainterJus({required this.index});
  final int index;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(126, 128, 83, 38)
      ..style = PaintingStyle.fill;

    final path = switch (index) {
      0 => _sbpLevel1PathJus(size),
      1 => _sbpLevel2PathJus(size),
      _ => _sbpLevel3PathJus(size),
    };

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_SbpLevelPainterJus oldDelegate) => false;
}

class _SbpLevel1ClipperJus extends CustomClipper<Path> {
  const _SbpLevel1ClipperJus({required this.index});
  final int index;
  @override
  Path getClip(Size size) {
    final path = switch (index) {
      0 => _sbpLevel1PathJus(size),
      1 => _sbpLevel2PathJus(size),
      _ => _sbpLevel3PathJus(size),
    };

    return path;
  }

  @override
  bool shouldReclip(_SbpLevel1ClipperJus oldClipper) => false;
}

class SbpLevel1WidgetJus extends StatelessWidget {
  const SbpLevel1WidgetJus({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      width: 270,
      child: ClipPath(
        clipper: _SbpLevel1ClipperJus(index: index),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: CustomPaint(
            painter: _SbpLevelPainterJus(index: index),
          ),
        ),
      ),
    );
  }
}
