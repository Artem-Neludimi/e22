import 'package:e22/core/extensions/rlf_context_extensions_pog.dart';
import 'package:flutter/material.dart';

import '../core/assets/gen/assets.gen.dart';
import 'sbp_widgets_jus.dart';

class SbpTasksJus extends StatelessWidget {
  const SbpTasksJus({super.key, required this.bottomNavigationBar});
  final Widget bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SbpAppBarJus(),
      bottomNavigationBar: bottomNavigationBar,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.sbpTasksBgJus.provider(),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
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
    );
  }
}
