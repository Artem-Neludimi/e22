// ignore_for_file: use_build_context_synchronously

import 'dart:developer' as developer;
import 'dart:math';

import 'package:flutter/material.dart';
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
        appBar: SbpAppBarJus(),
        bottomNavigationBar: widget.bottomNavigationBar,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24).copyWith(bottom: 40),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
