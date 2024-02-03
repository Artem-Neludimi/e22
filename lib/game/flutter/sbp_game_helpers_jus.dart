import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/rlf_app_cubit_pog.dart';
import '../../presentation/sbp_widgets_jus.dart';
import '../logic/rlf_game_bloc_pog.dart';

class SbpGameListenersJus extends StatelessWidget {
  const SbpGameListenersJus({
    super.key,
    required this.child,
  });

  final Widget child;
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RLFGameBlocPOG>();
    final appCubit = context.read<RLFAppCubitPog>();

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
      child: child,
    );
  }
}

class SbpProviderJus extends StatelessWidget {
  const SbpProviderJus({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RLFGameBlocPOG(),
      child: child,
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
            SbpButtonJus(
              onPressed: () {
                appCubit.addScore(bloc.state.score);
                final navigator = Navigator.of(context);
                while (navigator.canPop()) {
                  navigator.pop();
                }
              },
              text: '',
            ),
            const SizedBox(height: 24),
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
                SbpButtonJus(
                  onPressed: () {
                    appCubit.addScore(widget.bloc.state.score);
                    final navigator = Navigator.of(context);
                    while (navigator.canPop()) {
                      navigator.pop();
                    }
                  },
                  text: '',
                ),
                const SizedBox(height: 24),
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
                    const SizedBox.shrink(),
                    Text(
                      '1000',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
