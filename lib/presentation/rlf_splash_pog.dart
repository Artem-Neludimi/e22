// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer' as developer;

import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

import 'package:e22/core/assets/gen/assets.gen.dart';

import '../main.dart';

class SbpSplashScreenJus extends StatefulWidget {
  const SbpSplashScreenJus({super.key});

  @override
  State<SbpSplashScreenJus> createState() => _SbpSplashScreenJusState();
}

class _SbpSplashScreenJusState extends State<SbpSplashScreenJus> {
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    Future.delayed(Duration.zero, () async {
      await _sbpSetDeviceType();
      await _sbpInitDependencies();
      // await _sbpHandleNavigation();
      // await _sbpRequestTrackingPermission();
    });
    super.initState();
  }

  Future<void> _sbpRequestTrackingPermission() async {
    var status = await AppTrackingTransparency.requestTrackingAuthorization();

    if (status == TrackingStatus.notDetermined) {
      status = await AppTrackingTransparency.requestTrackingAuthorization();
    }

    if (status == TrackingStatus.authorized) {
      developer.log('Permission granted');
    } else {
      developer.log('Permission denied');
    }
  }

  Future<void> _sbpHandleNavigation() async {
    await Future.delayed(const Duration(seconds: 2));
    final name = rlfPrefsPog.getString('name');
    if (name == null || name.isEmpty) {
      // Navigator.of(context).pushReplacementNamed('/rlf-nickname-pog');
    } else {
      // Navigator.of(context).pushReplacementNamed('/rlf-menu-pog');
    }
  }

  Future<void> _sbpInitDependencies() async {
    rlfPrefsPog = await SharedPreferences.getInstance();
    FlameAudio.bgm.initialize();
  }

  Future<void> _sbpSetDeviceType() async {
    await Flame.device.fullScreen();
    await Flame.device.setPortrait();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.sbpSplashBgJus.provider(),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(30, 30, 30, 1),
              borderRadius: BorderRadius.circular(44),
            ),
            child: Assets.lottie.sbpLoadingJus.lottie(
              height: size.width * 0.5,
              width: size.width * 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
