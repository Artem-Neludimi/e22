// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:e22/core/extensions/sbp_context_extensions_jus.dart';
import 'package:e22/game/logic/sbp_game_config_cubit.dart';
import 'package:e22/logic/sbp_app_cubit_jus.dart';
import 'package:e22/presentation/sbp_widgets_jus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/assets/gen/assets.gen.dart';
import '../logic/sbp_cube_bloc_jus.dart';

class SbpProviderJus extends StatelessWidget {
  const SbpProviderJus({super.key, required this.child, required this.index});
  final int index;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SbpCubeBlocJus(),
        ),
        BlocProvider(
          create: (context) => SbpGameConfigCubit(level: index),
        ),
      ],
      child: child,
    );
  }
}

class SbpGameListenersJus extends StatefulWidget {
  const SbpGameListenersJus({
    super.key,
    required this.index,
    required this.child,
  });

  final int index;
  final Widget child;

  @override
  State<SbpGameListenersJus> createState() => _SbpGameListenersJusState();
}

class _SbpGameListenersJusState extends State<SbpGameListenersJus> {
  @override
  Widget build(BuildContext context) {
    final gameConfigCubit = context.read<SbpGameConfigCubit>();
    final appCubit = context.read<SbpAppCubitJus>();
    return MultiBlocListener(
      listeners: [
        BlocListener<SbpGameConfigCubit, SbpGameConfigState>(
          listenWhen: (previous, current) => previous.pause == false && current.pause == true,
          listener: (context, state) async {
            await showDialog(
              context: context,
              builder: (context) => _SbpPauseDialogJus(gameConfigCubit),
            );
            context.read<SbpGameConfigCubit>().sbpHidePauseJus();
          },
        ),
        BlocListener<SbpGameConfigCubit, SbpGameConfigState>(
          listenWhen: (previous, current) => previous.onboarding == false && current.onboarding == true,
          listener: (context, state) async {
            await showDialog(
              context: context,
              builder: (context) => _SbpOnboardingDialogJus(gameConfigCubit),
            );
            context.read<SbpGameConfigCubit>().sbpHideOnboardingJus();
          },
        ),
        BlocListener<SbpGameConfigCubit, SbpGameConfigState>(
          listenWhen: (previous, current) => previous.win == false && current.win == true,
          listener: (context, state) async {
            await showDialog(
              context: context,
              builder: (context) => _SbpWinDialogJus(gameConfigCubit, appCubit),
            );
            if (appCubit.state.levelsFinished <= widget.index) {
              appCubit.addLevelsFinished();
              appCubit.addScore(gameConfigCubit.state.score);
            }
          },
        ),
      ],
      child: widget.child,
    );
  }
}

class _SbpPauseDialogJus extends StatelessWidget {
  const _SbpPauseDialogJus(this.gameConfigCubit);
  final SbpGameConfigCubit gameConfigCubit;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Stack(
          children: [
            Assets.images.sbpDialogJus.image(),
            Positioned(
              top: 62,
              right: 0,
              left: 0,
              child: Center(
                child: Text(
                  'PAUSE',
                  style: context.berlinSans(size: 44),
                ),
              ),
            ),
            Positioned(
              top: 170,
              right: 0,
              left: 0,
              child: Center(
                child: Text(
                  'Game is\npaused',
                  textAlign: TextAlign.center,
                  style: context.berlinSans(
                    size: 28,
                    color: Colors.white,
                    weight: FontWeight.w100,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              right: 45,
              left: 45,
              child: Column(
                children: [
                  SbpButtonJus(
                    text: 'Resume',
                    onPressed: () {
                      context.pop();
                    },
                  ),
                  const SizedBox(height: 10),
                  SbpButtonJus(
                    isBlack: true,
                    text: 'Restart',
                    onPressed: () {
                      gameConfigCubit.sbpRestartJus();
                      context.pop();
                    },
                  ),
                  const SizedBox(height: 10),
                  SbpButtonJus(
                    isBlack: true,
                    text: 'Return to map',
                    onPressed: () {
                      while (context.canPop()) {
                        context.pop();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SbpWinDialogJus extends StatelessWidget {
  const _SbpWinDialogJus(this.gameConfigCubit, this.appCubit);
  final SbpGameConfigCubit gameConfigCubit;
  final SbpAppCubitJus appCubit;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Stack(
            children: [
              Assets.images.sbpDialogJus.image(),
              Positioned(
                top: 62,
                right: 0,
                left: 0,
                child: Center(
                  child: Text(
                    'YOU WIN',
                    style: context.berlinSans(size: 44),
                  ),
                ),
              ),
              Positioned(
                top: 170,
                bottom: 120,
                right: 0,
                left: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Your prize:',
                      style: context.berlinSans(
                        size: 44,
                        color: Colors.white,
                        weight: FontWeight.w100,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Assets.images.sbpCrownJus.image(
                          height: 44,
                          fit: BoxFit.fitHeight,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          gameConfigCubit.state.score.toString(),
                          style: context.berlinSans(
                            size: 44,
                            color: Colors.white,
                            weight: FontWeight.w100,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 30,
                right: 45,
                left: 45,
                child: Column(
                  children: [
                    SbpButtonJus(
                      isBlack: true,
                      text: 'Return to map',
                      onPressed: () {
                        while (context.canPop()) {
                          context.pop();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SbpOnboardingDialogJus extends StatefulWidget {
  const _SbpOnboardingDialogJus(this.gameConfigCubit);
  final SbpGameConfigCubit gameConfigCubit;

  @override
  State<_SbpOnboardingDialogJus> createState() => _SbpOnboardingDialogJusState();
}

class _SbpOnboardingDialogJusState extends State<_SbpOnboardingDialogJus> {
  bool _isTimerStarted = false;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Material(
        color: Colors.transparent,
        child: _isTimerStarted
            ? _TimerDialog(gameConfigCubit: widget.gameConfigCubit)
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.images.sbpGameOnboardingDialogJus.image(),
                    const SizedBox(height: 4),
                    SbpButtonJus(
                      text: 'Start game',
                      onPressed: () {
                        setState(() => _isTimerStarted = true);
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class _TimerDialog extends StatefulWidget {
  const _TimerDialog({required this.gameConfigCubit});
  final SbpGameConfigCubit gameConfigCubit;
  @override
  State<_TimerDialog> createState() => _TimerDialogState();
}

class _TimerDialogState extends State<_TimerDialog> {
  Timer? _timer;
  @override
  initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timer.tick == 3) {
        widget.gameConfigCubit.sbpHideOnboardingJus();
        context.pop();
      }

      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '${3 - _timer!.tick}',
        style: context.sourceSans(
          size: 77,
          color: const Color(0xFFE0B068),
        ),
      ),
    );
  }
}
