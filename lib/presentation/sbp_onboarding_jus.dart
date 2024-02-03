import 'package:e22/core/extensions/rlf_context_extensions_pog.dart';
import 'package:e22/presentation/rlf_widgets_pog.dart';
import 'package:flutter/material.dart';

import 'package:e22/core/assets/gen/assets.gen.dart';

class SbpOnboardingJus extends StatelessWidget {
  const SbpOnboardingJus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.sbpOnboardingBg1Jus.provider(),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Assets.images.rlfGameOverviewPog.image(),
                RLFGameButtonsPOG(
                  boostOnPressed: () {},
                  leftOnPressed: () {},
                  rightOnPressed: () {},
                  trampolineOnPressed: () {},
                ),
                Text(
                  'HOW TO\nPLAY?',
                  style: context.inter(),
                ),
                Text(
                  'The goal of the game is to get the ball as far as possible. You need to be afraid of saws, or you will lose the game. Walls are safe, but they slow you down. You can also collect coins to get a better score.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        fontWeight: FontWeight.w100,
                      ),
                ),
                SizedBox(
                  height: context.isSE ? 55 : 70,
                  width: double.infinity,
                  child: RLFAppButtonPOG(
                    onPressed: () => Navigator.of(context).pushReplacementNamed('/rlf-menu-pog'),
                    child: Text('CONTINUE', style: Theme.of(context).textTheme.bodyMedium),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
