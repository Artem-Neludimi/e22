// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:e22/core/assets/gen/assets.gen.dart';

import '../main.dart';

class RLFSplashScreenPog extends StatefulWidget {
  const RLFSplashScreenPog({super.key});

  @override
  State<RLFSplashScreenPog> createState() => _RLFSplashScreenPogState();
}

class _RLFSplashScreenPogState extends State<RLFSplashScreenPog> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await Flame.device.fullScreen();
      await Flame.device.setPortraitDownOnly();
      rlfPrefsPog = await SharedPreferences.getInstance();
      FlameAudio.bgm.initialize();

      await Future.delayed(const Duration(seconds: 2));
      final name = rlfPrefsPog.getString('name');
      if (name == null || name.isEmpty) {
        Navigator.of(context).pushReplacementNamed('/rlf-nickname-pog');
      } else {
        Navigator.of(context).pushReplacementNamed('/rlf-menu-pog');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.rlfSplashBgPog.provider(),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Assets.images.rlfIconPog.image(),
            const SizedBox(height: 46),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('LOADING'),
                SizedBox(width: 4),
                SizedBox(
                  width: 30,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: _ThreeDots(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 46),
          ],
        ),
      ),
    );
  }
}

class _ThreeDots extends StatefulWidget {
  const _ThreeDots();

  @override
  State<_ThreeDots> createState() => _ThreeDotsState();
}

class _ThreeDotsState extends State<_ThreeDots> {
  Timer? _timer;
  String _dots = '';
  @override
  void initState() {
    _timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      setState(() {
        if (_dots.length == 3) {
          _dots = '';
        } else {
          _dots += '.';
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _dots,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: const Color.fromRGBO(66, 182, 70, 1),
            letterSpacing: 4,
          ),
    );
  }
}
