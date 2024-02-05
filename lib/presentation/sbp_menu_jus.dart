// ignore_for_file: use_build_context_synchronously

import 'dart:developer' as developer;
import 'dart:math';

import 'package:e22/core/extensions/rlf_context_extensions_pog.dart';
import 'package:e22/core/navigation/sbp_router_jus.dart';
import 'package:e22/logic/rlf_app_cubit_pog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    _redirect();
  }

  void _redirect() async {
    final random = Random();
    int delay = random.nextInt(30) + 30;
    if ((rlfPrefsPog.getBool('isFirstTime') == null)) {
      await Future.delayed(Duration(seconds: delay));
      rateMyApp.showRateDialog(context);
      rlfPrefsPog.setBool('isFirstTime', false);
      developer.log('Redirecting to app store');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
    return GestureDetector(
      onTap: () {
        if (isAvailable) {
          SbpRoutesJus.game.push(context, extra: index);
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
            if (index != 0 && index != 1 && index != 2)
              Positioned(
                bottom: -20,
                left: 20,
                right: 9,
                height: 35,
                child: SbpMoneyBoardJus(
                  money: '${index * 800}',
                ),
              ),
          ],
        ),
      ),
    );
  }
}
