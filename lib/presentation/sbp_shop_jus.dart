import 'package:flutter/material.dart';

import 'sbp_widgets_jus.dart';

class SbpShopJus extends StatelessWidget {
  const SbpShopJus({super.key, required this.bottomNavigationBar});
  final Widget bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SbpAppBarJus(),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
