import 'package:e22/game/logic/sbp_cube_bloc_jus.dart';
import 'package:e22/game/logic/sbp_game_config_cubit.dart';
import 'package:e22/logic/rlf_app_cubit_pog.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/assets/gen/assets.gen.dart';
import '../flame/sbp_game_jus.dart';
import 'sbp_game_helpers_jus.dart';
import 'sbp_levels_jus.dart';

class SbpGameScreenJus extends StatelessWidget {
  const SbpGameScreenJus({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: SbpProviderJus(
        index: index,
        child: const SbpGameListenersJus(
          child: _SbpGameViewJus(),
        ),
      ),
    );
  }
}

class _SbpGameViewJus extends StatefulWidget {
  const _SbpGameViewJus();

  @override
  State<_SbpGameViewJus> createState() => _SbpGameViewJusState();
}

class _SbpGameViewJusState extends State<_SbpGameViewJus> {
  late final Game game;
  late final RLFAppCubitPog appCubit;
  late final SbpGameConfigCubit gameConfigCubit;
  late final SbpCubeBlocJus cubeBloc;
  @override
  void initState() {
    cubeBloc = context.read<SbpCubeBlocJus>();
    appCubit = context.read<RLFAppCubitPog>();
    gameConfigCubit = context.read<SbpGameConfigCubit>();
    game = SbpFlameGameJus(cubeBloc, appCubit, gameConfigCubit);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Assets.images.sbpGameBgJus.image(
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        const _Level(),
        GameWidget(game: game),
        _PauseButton(bloc: cubeBloc),
        const _RestartButton(),
      ],
    );
  }
}

class _Level extends StatelessWidget {
  const _Level();

  @override
  Widget build(BuildContext context) {
    return const Positioned.fill(
      child: Center(
        child: SbpLevel1WidgetJus(),
      ),
    );
  }
}

class _RestartButton extends StatelessWidget {
  const _RestartButton();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 15,
      right: 15,
      child: GestureDetector(
        onTap: () {
          context.read<SbpGameConfigCubit>().sbpRestartJus();
        },
        child: Assets.images.sbpRestartJus.image(),
      ),
    );
  }
}

class _PauseButton extends StatelessWidget {
  const _PauseButton({
    required this.bloc,
  });

  final SbpCubeBlocJus bloc;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 15,
      left: 15,
      child: GestureDetector(
        onTap: () {
          // bloc.add(const RLFGamePausePOG());
        },
        child: Assets.images.sbpPauseJus.image(),
      ),
    );
  }
}
