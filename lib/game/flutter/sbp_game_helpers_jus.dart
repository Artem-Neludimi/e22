// ignore_for_file: use_build_context_synchronously

import 'package:e22/core/extensions/rlf_context_extensions_pog.dart';
import 'package:e22/game/logic/sbp_game_config_cubit.dart';
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

class SbpGameListenersJus extends StatelessWidget {
  const SbpGameListenersJus({
    super.key,
    required this.child,
  });

  final Widget child;
  @override
  Widget build(BuildContext context) {
    final gameConfigCubit = context.read<SbpGameConfigCubit>();
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
      ],
      child: child,
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
