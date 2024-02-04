import 'package:e22/game/logic/rlf_game_bloc_pog.dart';
import 'package:e22/logic/rlf_app_cubit_pog.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/assets/gen/assets.gen.dart';
import '../flame/sbp_flame_game_jus.dart';
import 'sbp_game_helpers_jus.dart';
import 'sbp_levels_jus.dart';

class SbpGameScreenJus extends StatelessWidget {
  const SbpGameScreenJus({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: true,
      child: SbpProviderJus(
        child: SbpGameListenersJus(
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
  late final RLFGameBlocPOG bloc;
  @override
  void initState() {
    bloc = context.read<RLFGameBlocPOG>();
    appCubit = context.read<RLFAppCubitPog>();
    game = SbpFlameGameJus(bloc, appCubit);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GameWidget(game: game),
        _PauseButton(bloc: bloc),
        const _RestartButton(),
        const Positioned.fill(
          child: Center(
            child: SbpLevel1WidgetJus(),
          ),
        ),
      ],
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
      child: Assets.images.sbpRestartJus.image(),
    );
  }
}

class _PauseButton extends StatelessWidget {
  const _PauseButton({
    required this.bloc,
  });

  final RLFGameBlocPOG bloc;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 15,
      left: 15,
      child: GestureDetector(
        onTap: () {
          bloc.add(const RLFGamePausePOG());
        },
        child: Assets.images.sbpPauseJus.image(),
      ),
    );
  }
}
