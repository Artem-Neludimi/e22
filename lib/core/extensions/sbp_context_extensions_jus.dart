import 'package:flutter/material.dart';

extension SbpContextExtensionsJus on BuildContext {
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Center(child: Text(message)),
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;
  bool get isSE => width <= 400;

  TextStyle inter({
    double size = 16,
    Color color = Colors.white,
    FontWeight weight = FontWeight.w500,
  }) {
    if (isSE) size = size * 0.8;
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: size,
      color: color,
      fontWeight: weight,
    );
  }

  TextStyle sourceSans({
    double size = 22,
    Color color = Colors.white,
    FontWeight weight = FontWeight.normal,
  }) {
    if (isSE) size = size * 0.8;
    return TextStyle(
      fontFamily: 'SourceSans',
      fontSize: size,
      color: color,
      fontWeight: weight,
    );
  }

  TextStyle berlinSans({
    double size = 32,
    Color color = Colors.white,
    FontWeight weight = FontWeight.w800,
  }) {
    if (isSE) size = size * 0.8;
    return TextStyle(
      fontFamily: 'BerlinSans',
      fontSize: size,
      color: color,
      fontWeight: weight,
    );
  }

  TextStyle sourceCode({
    double size = 22,
    Color color = Colors.white,
    FontWeight weight = FontWeight.bold,
  }) {
    if (isSE) size = size * 0.8;
    return TextStyle(
      fontFamily: 'SourceCode',
      fontSize: size,
      color: color,
      fontWeight: weight,
    );
  }
}
