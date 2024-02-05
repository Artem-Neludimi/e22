import 'package:e22/core/extensions/sbp_context_extensions_jus.dart';
import 'package:flutter/material.dart';

import '../core/assets/gen/assets.gen.dart';
import 'sbp_widgets_jus.dart';

class SbpTasksJus extends StatelessWidget {
  const SbpTasksJus({super.key, required this.bottomNavigationBar});
  final Widget bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Assets.images.sbpTasksBgJus.image(
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Scaffold(
          appBar: SbpAppBarJus(context: context),
          bottomNavigationBar: bottomNavigationBar,
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Completed tasks: 0/5',
                  style: context.sourceSans(size: 33),
                ),
                const SizedBox(height: 16),
                Assets.images.sbpTasksJus.image()
              ],
            ),
          ),
        ),
      ],
    );
  }
}
