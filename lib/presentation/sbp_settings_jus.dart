import 'package:e22/presentation/sbp_widgets_jus.dart';
import 'package:flutter/material.dart';

class SbpSettingsJus extends StatelessWidget {
  const SbpSettingsJus({super.key, required this.bottomNavigationBar});
  final Widget bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SbpAppBarJus(),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
