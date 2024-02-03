import 'package:e22/game/logic/rlf_game_bloc_pog.dart';
import 'package:e22/logic/rlf_app_cubit_pog.dart';
import 'package:e22/presentation/sbp_widgets_jus.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/assets/gen/assets.gen.dart';
import '../flame/sbp_flame_game_jus.dart';
import 'sbp_game_helpers_jus.dart';

class SbpGameScreenJus extends StatelessWidget {
  const SbpGameScreenJus({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: false,
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
        _GameButtons(),
        _PauseButton(bloc: bloc),
        const _Score(),
      ],
    );
  }
}

class _Score extends StatelessWidget {
  const _Score();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 18,
      right: 33,
      child: Material(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'SCORE',
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.5),
                  ),
            ),
            const SizedBox(height: 8),
            BlocBuilder<RLFGameBlocPOG, RLFGameStatePOG>(
              builder: (context, state) {
                return Text(
                  '${state.score}',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontSize: 33,
                      ),
                );
              },
            ),
          ],
        ),
      ),
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
      top: 18,
      left: 33,
      child: Material(
        color: Colors.transparent,
        child: RLFRoundButtonPOG(
          onPressed: () {
            bloc.add(const RLFGamePausePOG());
          },
          radius: 66,
          child: const Icon(
            Icons.pause,
            color: Colors.white,
            size: 35,
          ),
        ),
      ),
    );
  }
}

class _GameButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<RLFGameBlocPOG>();
    final appState = context.read<RLFAppCubitPog>().state;
    return Positioned(
      left: 24,
      right: 24,
      bottom: 24,
      child: Material(
        color: Colors.transparent,
        child: RLFGameButtonsPOG(
          leftOnPressed: () => bloc.add(const RLFGameJumpLeftPOG()),
          rightOnPressed: () => bloc.add(const RLFGameJumpRightPOG()),
          trampolineOnPressed: () => bloc.add(const RLFGameTrampolinePOG()),
          boostOnPressed: () => bloc.add(const RLFGameMultiplierPOG()),
          haveTrampoline: appState.trampolineCount > 0 && bloc.state.didUseTrampoline == false,
          haveMultiplier: appState.scoreMultiplierCount > 0 && bloc.state.didUseScoreMultiplier == false,
        ),
      ),
    );
  }
}
