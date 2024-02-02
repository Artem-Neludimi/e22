import 'package:e22/game/rlf_flame_game_pog.dart';
import 'package:e22/game/rlf_game_bloc_pog.dart';
import 'package:e22/logic/rlf_app_cubit_pog.dart';
import 'package:e22/presentation/rlf_widgets_pog.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/assets/gen/assets.gen.dart';

class RLFGameScreenPOG extends StatefulWidget {
  const RLFGameScreenPOG({super.key});

  @override
  State<RLFGameScreenPOG> createState() => _RLFGameScreenPOGState();
}

class _RLFGameScreenPOGState extends State<RLFGameScreenPOG> {
  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: false,
      child: _RLFProviderPOG(
        child: _RLFGamePresentationPOG(),
      ),
    );
  }
}

class _RLFProviderPOG extends StatelessWidget {
  const _RLFProviderPOG({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RLFGameBlocPOG(),
      child: child,
    );
  }
}

class _RLFGamePresentationPOG extends StatefulWidget {
  const _RLFGamePresentationPOG();

  @override
  State<_RLFGamePresentationPOG> createState() => _RLFGamePresentationPOGState();
}

class _RLFGamePresentationPOGState extends State<_RLFGamePresentationPOG> {
  late final Game game;
  late final RLFAppCubitPog appCubit;
  late final RLFGameBlocPOG bloc;
  @override
  void initState() {
    bloc = context.read<RLFGameBlocPOG>();
    appCubit = context.read<RLFAppCubitPog>();
    game = RLFFlameGamePog(bloc, appCubit);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RLFGameBlocPOG, RLFGameStatePOG>(
          listenWhen: (previous, current) => current.gameOver,
          listener: (context, state) {
            showModalBottomSheet(
              context: context,
              isDismissible: false,
              enableDrag: false,
              isScrollControlled: false,
              builder: (context) => _GameOverBottomSheet(bloc, context.read<RLFAppCubitPog>()),
            );
          },
        ),
        BlocListener<RLFGameBlocPOG, RLFGameStatePOG>(
          listenWhen: (previous, current) => previous.gameOver && !current.gameOver,
          listener: (context, state) {
            Navigator.of(context).pop();
          },
        ),
        BlocListener<RLFGameBlocPOG, RLFGameStatePOG>(
          listenWhen: (previous, current) => previous.pause != current.pause,
          listener: (context, state) {
            if (state.pause) {
              showModalBottomSheet(
                context: context,
                isDismissible: false,
                enableDrag: false,
                isScrollControlled: false,
                builder: (context) => _PauseModalBottomSheet(bloc, context.read<RLFAppCubitPog>()),
              );
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
        BlocListener<RLFGameBlocPOG, RLFGameStatePOG>(
          listenWhen: (previous, current) => previous.didUseTrampoline == false && current.didUseTrampoline,
          listener: (context, state) {
            appCubit.useTrampoline();
          },
        ),
        BlocListener<RLFGameBlocPOG, RLFGameStatePOG>(
          listenWhen: (previous, current) => previous.didUseScoreMultiplier == false && current.didUseScoreMultiplier,
          listener: (context, state) {
            appCubit.useScoreMultiplier();
          },
        ),
      ],
      child: Stack(
        children: [
          const SizedBox(
            height: double.infinity,
            width: double.infinity,
          ),
          GameWidget(game: game),
          _GameButtons(),
          _PauseButton(bloc: bloc),
          Positioned(
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
          ),
        ],
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

class _PauseModalBottomSheet extends StatelessWidget {
  final RLFAppCubitPog appCubit;
  final RLFGameBlocPOG bloc;
  const _PauseModalBottomSheet(this.bloc, this.appCubit);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(13, 12, 80, 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'PAUSE',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 32),
            Text(
              'CURRENT SCORE',
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.5),
                  ),
            ),
            const SizedBox(height: 24),
            Text(
              '${bloc.state.score}',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 32),
            RLFAppButtonPOG(
              onPressed: () {
                appCubit.addScore(bloc.state.score);
                final navigator = Navigator.of(context);
                while (navigator.canPop()) {
                  navigator.pop();
                }
              },
              child: Text(
                'MAIN MENU',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 24),
            RLFAppButtonPOG(
              onPressed: () {
                bloc.add(const RLFGameResumePOG());
              },
              child: Text(
                'BACK TO GAME',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GameOverBottomSheet extends StatefulWidget {
  const _GameOverBottomSheet(this.bloc, this.appCubit);
  final RLFGameBlocPOG bloc;
  final RLFAppCubitPog appCubit;

  @override
  State<_GameOverBottomSheet> createState() => _GameOverBottomSheetState();
}

class _GameOverBottomSheetState extends State<_GameOverBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final appCubit = context.watch<RLFAppCubitPog>();
    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(13, 12, 80, 1),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'RESULTS',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 32),
              Text(
                'YOUR SCORE',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.5),
                    ),
              ),
              const SizedBox(height: 24),
              Text(
                '${widget.bloc.state.score}',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              if (appCubit.state.isGainBonus) ...[
                const SizedBox(height: 24),
                RLFAppButtonPOG(
                  onPressed: () {
                    appCubit.addScore(widget.bloc.state.score);
                    final navigator = Navigator.of(context);
                    while (navigator.canPop()) {
                      navigator.pop();
                    }
                  },
                  child: Text(
                    'MAIN MENU',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: 24),
                RLFAppButtonPOG(
                  onPressed: () {},
                  child: FittedBox(
                    child: Text(
                      'WATCH AD & CONTINUE',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ] else ...[
                Divider(
                  height: 48,
                  color: Colors.white.withOpacity(0.2),
                ),
                Text(
                  'CHOSE YOUR BONUS',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontSize: 18,
                        color: Colors.white.withOpacity(0.5),
                      ),
                ),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    _Bonus(),
                    _Bonus(),
                    _Bonus(),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _Bonus extends StatefulWidget {
  const _Bonus();

  @override
  State<_Bonus> createState() => _BonusState();
}

class _BonusState extends State<_Bonus> {
  bool _isPick = false;
  @override
  Widget build(BuildContext context) {
    final appCubit = context.watch<RLFAppCubitPog>();
    return Expanded(
      child: GestureDetector(
        onTap: () async {
          setState(() => _isPick = !_isPick);
          await Future.delayed(const Duration(milliseconds: 300));
          appCubit.setGainBonus();
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _isPick
              ? Column(
                  children: [
                    Assets.images.rlfStarPog.image(),
                    Text(
                      '1000',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                    ),
                  ],
                )
              : Assets.images.rlfPresentPog.image(),
        ),
      ),
    );
  }
}
