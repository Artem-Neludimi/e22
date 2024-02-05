import 'package:e22/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SbpAppCubitJus extends Cubit<SbpAppStateJus> {
  SbpAppCubitJus()
      : super(
          SbpAppStateJus(
            score: rlfPrefsPog.getInt('score') ?? 0,
            levelsFinished: rlfPrefsPog.getInt('levelsFinished') ?? 0,
            boughtLevels: rlfPrefsPog.getStringList('boughtLevels')?.map((e) => int.parse(e)).toList() ?? [0, 1, 2],
            notification: rlfPrefsPog.getBool('notification') ?? true,
          ),
        );

  void addScore(int score) {
    rlfPrefsPog.setInt('score', state.score + score);
    emit(state.copyWith(score: state.score + score));
  }

  void addLevelsFinished() {
    rlfPrefsPog.setInt('levelsFinished', state.levelsFinished + 1);
    emit(state.copyWith(levelsFinished: state.levelsFinished + 1));
  }

  void tryBuyLevel(int level, int price) {
    if (state.score < price) throw Exception('Not enough score');
    final boughtLevels = state.boughtLevels;
    boughtLevels.add(level);
    rlfPrefsPog.setStringList('boughtLevels', boughtLevels.map((e) => e.toString()).toList());
    emit(state.copyWith(boughtLevels: boughtLevels));
  }

  void toggleNotification() {
    rlfPrefsPog.setBool('notification', !state.notification);
    emit(state.copyWith(notification: !state.notification));
  }
}

class SbpAppStateJus {
  const SbpAppStateJus({
    required this.score,
    required this.levelsFinished,
    required this.boughtLevels,
    required this.notification,
  });
  final int score;
  final int levelsFinished;
  final List<int> boughtLevels;
  final bool notification;

  SbpAppStateJus copyWith({
    int? score,
    int? levelsFinished,
    List<int>? boughtLevels,
    bool? notification,
  }) {
    return SbpAppStateJus(
      score: score ?? this.score,
      levelsFinished: levelsFinished ?? this.levelsFinished,
      boughtLevels: boughtLevels ?? this.boughtLevels,
      notification: notification ?? this.notification,
    );
  }
}
