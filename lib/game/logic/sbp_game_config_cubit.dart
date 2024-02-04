import 'package:flutter_bloc/flutter_bloc.dart';

class SbpGameConfigCubit extends Cubit<SbpGameConfigState> {
  SbpGameConfigCubit({
    required int level,
  }) : super(SbpGameConfigState(score: (level + 1) * 50));

  void sbpShowOnboardingJus() => emit(state.copyWith(onboarding: true));
  void sbpHideOnboardingJus() => emit(state.copyWith(onboarding: false));
  void sbpShowPauseJus() => emit(state.copyWith(pause: true));
  void sbpHidePauseJus() => emit(state.copyWith(pause: false));
  void sbpRestartJus() => emit(state.copyWith(restart: true));
  void sbpResetRestartJus() => emit(state.copyWith(restart: false));
  void sbpSetWinJus() => emit(state.copyWith(win: true));
}

class SbpGameConfigState {
  const SbpGameConfigState({
    required this.score,
    this.onboarding = false,
    this.pause = false,
    this.restart = false,
    this.win = false,
  });
  final int score;
  final bool onboarding;
  final bool pause;
  final bool restart;
  final bool win;

  SbpGameConfigState copyWith({
    int? score,
    bool? onboarding,
    bool? pause,
    bool? restart,
    bool? win,
  }) {
    return SbpGameConfigState(
      score: score ?? this.score,
      onboarding: onboarding ?? this.onboarding,
      pause: pause ?? this.pause,
      restart: restart ?? this.restart,
      win: win ?? this.win,
    );
  }
}
