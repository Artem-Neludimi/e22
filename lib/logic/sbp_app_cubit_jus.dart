import 'package:e22/core/assets/gen/assets.gen.dart';
import 'package:e22/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SbpAppCubitJus extends Cubit<SbpAppStateJus> {
  SbpAppCubitJus()
      : super(
          SbpAppStateJus(
            score: sbpPrefsJus.getInt('score') ?? 0,
            levelsFinished: sbpPrefsJus.getInt('levelsFinished') ?? 0,
            boughtLevels: sbpPrefsJus.getStringList('boughtLevels')?.map((e) => int.parse(e)).toList() ?? [0, 1, 2],
            notification: sbpPrefsJus.getBool('notification') ?? true,
            cubeImage: sbpPrefsJus.getString('cubeImage') ?? Assets.images.sbpCubeJus.path,
            boughtImages: sbpPrefsJus.getStringList('boughtImages') ?? [Assets.images.sbpCubeJus.path],
          ),
        );

  void addScore(int score) {
    sbpPrefsJus.setInt('score', state.score + score);
    emit(state.copyWith(score: state.score + score));
  }

  void addLevelsFinished() {
    sbpPrefsJus.setInt('levelsFinished', state.levelsFinished + 1);
    emit(state.copyWith(levelsFinished: state.levelsFinished + 1));
  }

  void tryBuyLevel(int level, int price) {
    if (state.score < price) throw Exception('Not enough credits');
    final boughtLevels = state.boughtLevels.toList();
    boughtLevels.add(level);
    sbpPrefsJus.setStringList('boughtLevels', boughtLevels.map((e) => e.toString()).toList());
    emit(state.copyWith(boughtLevels: boughtLevels));
  }

  void toggleNotification() {
    sbpPrefsJus.setBool('notification', !state.notification);
    emit(state.copyWith(notification: !state.notification));
  }

  void tryBuyImage(String image, int price) {
    if (state.score < price) throw Exception('Not enough credits');
    final boughtImages = state.boughtImages.toList();
    boughtImages.add(image);
    sbpPrefsJus.setStringList('boughtImages', boughtImages);
    sbpPrefsJus.setInt('score', state.score - price);
    emit(state.copyWith(boughtImages: boughtImages, score: state.score - price));
  }

  void changeCubeImage(String image) {
    sbpPrefsJus.setString('cubeImage', image);
    emit(state.copyWith(cubeImage: image));
  }
}

class SbpAppStateJus {
  const SbpAppStateJus({
    required this.score,
    required this.levelsFinished,
    required this.boughtLevels,
    required this.notification,
    required this.cubeImage,
    required this.boughtImages,
  });
  final int score;
  final int levelsFinished;
  final List<int> boughtLevels;
  final bool notification;
  final String cubeImage;
  final List<String> boughtImages;

  SbpAppStateJus copyWith({
    int? score,
    int? levelsFinished,
    List<int>? boughtLevels,
    bool? notification,
    String? cubeImage,
    List<String>? boughtImages,
  }) {
    return SbpAppStateJus(
      score: score ?? this.score,
      levelsFinished: levelsFinished ?? this.levelsFinished,
      boughtLevels: boughtLevels ?? this.boughtLevels,
      notification: notification ?? this.notification,
      cubeImage: cubeImage ?? this.cubeImage,
      boughtImages: boughtImages ?? this.boughtImages,
    );
  }
}
