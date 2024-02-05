// ignore_for_file: use_build_context_synchronously

import 'dart:developer' as developer;
import 'dart:math';

import 'package:e22/core/extensions/sbp_context_extensions_jus.dart';
import 'package:e22/core/navigation/sbp_router_jus.dart';
import 'package:e22/logic/sbp_app_cubit_jus.dart';
import 'package:e22/logic/sbp_bonus_cubit_jus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:rate_my_app/rate_my_app.dart';

import 'package:e22/core/assets/gen/assets.gen.dart';

import '../main.dart';
import 'sbp_widgets_jus.dart';

class SbpMenuJus extends StatefulWidget {
  const SbpMenuJus({super.key, required this.bottomNavigationBar});
  final Widget bottomNavigationBar;

  @override
  State<SbpMenuJus> createState() => _SbpMenuJusState();
}

class _SbpMenuJusState extends State<SbpMenuJus> {
  final rateMyApp = RateMyApp(
    minDays: 0,
    minLaunches: 0,
    remindDays: 0,
    remindLaunches: 0,
  )..init();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SbpBonusCubitJus>().init();
    });
    _redirect();
  }

  void _redirect() async {
    final random = Random();
    int delay = random.nextInt(30) + 30;
    if ((sbpPrefsJus.getBool('isFirstTime') == null)) {
      await Future.delayed(Duration(seconds: delay));
      rateMyApp.showRateDialog(context);
      sbpPrefsJus.setBool('isFirstTime', false);
      developer.log('Redirecting to app store');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SbpBonusCubitJus, SbpBonusStateJus>(
      bloc: context.read<SbpBonusCubitJus>(),
      listenWhen: (previous, current) {
        return previous.showBonus == false && current.showBonus == true;
      },
      listener: (context, state) {
        showDialog(
          context: context,
          builder: (context) {
            return const _BonusDialog();
          },
        ).whenComplete(() {
          context.read<SbpBonusCubitJus>().setBonusTime();
          context.read<SbpAppCubitJus>().addScore(100);
        });
      },
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.sbpMenuBgJus.provider(),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          appBar: SbpAppBarJus(context: context),
          bottomNavigationBar: widget.bottomNavigationBar,
          body: SafeArea(
            child: SingleChildScrollView(
              reverse: true,
              child: Wrap(
                verticalDirection: VerticalDirection.up,
                children: List.generate(
                  40,
                  (index) {
                    if (index % 3 == 0) return Center(child: _Item(index));
                    return SizedBox(
                      width: context.width / 2,
                      child: Center(
                        child: _Item(index),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item(this.index);
  final int index;

  @override
  Widget build(BuildContext context) {
    final boughtLevels = context.watch<SbpAppCubitJus>().state.boughtLevels;
    final levelsFinished = context.watch<SbpAppCubitJus>().state.levelsFinished;
    final isAvailable = boughtLevels.contains(index) && levelsFinished >= index;
    final price = index * 800;
    return GestureDetector(
      onTap: () {
        if (isAvailable) {
          SbpRoutesJus.game.push(context, extra: index);
        } else {
          try {
            context.read<SbpAppCubitJus>().tryBuyLevel(index, price);
          } catch (e) {
            showDialog(
              context: context,
              builder: (context) => const NotEnoughMoneyDialog(),
            );
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 70,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                color: isAvailable ? null : Colors.black,
                gradient: isAvailable
                    ? const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(224, 176, 104, 1),
                          Color.fromRGBO(78, 56, 38, 1),
                        ],
                      )
                    : null,
                border: isAvailable
                    ? Border.all(
                        color: Colors.white,
                        width: 4,
                      )
                    : const GradientBoxBorder(
                        width: 4,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromRGBO(224, 176, 104, 1),
                            Color.fromRGBO(78, 56, 38, 1),
                          ],
                        ),
                      ),
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: context.sourceSans(
                    size: 33,
                    color: isAvailable ? Colors.white : const Color.fromRGBO(224, 176, 104, 1),
                    weight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            if (!boughtLevels.contains(index))
              Positioned(
                bottom: -20,
                left: 20,
                right: 9,
                height: 35,
                child: SbpMoneyBoardJus(
                  money: '$price',
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _BonusDialog extends StatefulWidget {
  const _BonusDialog();

  @override
  State<_BonusDialog> createState() => _BonusDialogState();
}

class _BonusDialogState extends State<_BonusDialog> {
  Alignment _alignment = Alignment.centerLeft;
  bool _showReward = false;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onHorizontalDragUpdate: (details) async {
          if (details.primaryDelta! > 0) {
            setState(() => _alignment = Alignment.centerRight);
            await Future.delayed(const Duration(milliseconds: 700));
            setState(() => _showReward = true);
          }
        },
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Stack(
              children: [
                Assets.images.sbpDialogJus.image(),
                Positioned(
                  top: 70,
                  left: 20,
                  right: 20,
                  child: Text(
                    'DAILY BONUS',
                    style: context.berlinSans(
                      size: 35,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Positioned(
                  top: 150,
                  bottom: 20,
                  left: 35,
                  right: 35,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(flex: 2),
                      Stack(
                        children: [
                          Assets.images.sbpBonusLineJus.image(),
                          Positioned(
                            top: 4,
                            bottom: 4,
                            left: 4,
                            right: 2,
                            child: AnimatedAlign(
                              duration: const Duration(milliseconds: 400),
                              alignment: _alignment,
                              child: Assets.images.sbpCubeJus.image(),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(flex: 2),
                      if (_showReward == false)
                        Text(
                          'Swipe cube to get your\nprize',
                          textAlign: TextAlign.center,
                          style: context.sourceCode(),
                        )
                      else ...[
                        Text('Your reward:', style: context.sourceCode()),
                        const SizedBox(height: 12),
                        const SizedBox(width: 150, child: SbpMoneyBoardJus(money: '100')),
                      ],
                      const Spacer(flex: 3),
                      if (_showReward == false)
                        Assets.images.sbpPointerJus.image()
                      else
                        SbpButtonJus(
                          onPressed: () {
                            context.pop();
                          },
                          text: 'Get reward',
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
