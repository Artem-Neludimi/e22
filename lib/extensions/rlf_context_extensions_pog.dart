import 'package:flutter/material.dart';

extension RlfContextExtensionsPog on BuildContext {
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Center(child: Text(message)),
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  bool get isSE {
    final size = MediaQuery.sizeOf(this);
    return size.width <= 400;
  }
}
