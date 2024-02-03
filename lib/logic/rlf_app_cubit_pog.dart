import 'dart:async';

import 'package:e22/core/assets/gen/assets.gen.dart';
import 'package:e22/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RLFAppCubitPog extends Cubit<RLFAppStatePog> {
  RLFAppCubitPog()
      : super(
          RLFAppStatePog(
            name: rlfPrefsPog.getString('name') ?? '',
            score: rlfPrefsPog.getInt('score') ?? 0,
            trampolineCount: rlfPrefsPog.getInt('trampolineCount') ?? 0,
            scoreMultiplierCount: rlfPrefsPog.getInt('scoreMultiplierCount') ?? 0,
            ballImage: rlfPrefsPog.getString('ballImage') ?? 'Assets.images.rlfBallPog.path,',
            avatarImage: rlfPrefsPog.getString('avatarImage') ?? 'Assets.images.rlfFootballer1Pog.path',
            boughtImages: rlfPrefsPog.getStringList('boughtImages') ??
                [
                  'Assets.images.rlfBallPog.path',
                  'Assets.images.rlfFootballer1Pog.path',
                ],
            sound: true,
            isGainBonus: false,
            timeBonusGained: rlfPrefsPog.getInt('timeBonusGained'),
          ),
        ) {
    timeSub = Stream<void>.periodic(const Duration(milliseconds: 250)).listen((_) {
      final timeBonusGained = rlfPrefsPog.getInt('timeBonusGained');
      if (timeBonusGained != null) {
        final now = DateTime.now();
        final dateTimeFromInt = DateTime.fromMillisecondsSinceEpoch(timeBonusGained);
        final deference = now.difference(dateTimeFromInt);
        if (deference.inMinutes >= 20) {
          emit(state.copyWith(isGainBonus: false));
        }
      }
    });
  }

  StreamSubscription? timeSub;

  @override
  Future<void> close() {
    timeSub?.cancel();
    return super.close();
  }

  void setName(String name) {
    rlfPrefsPog.setString('name', name);
    emit(state.copyWith(name: name));
  }

  void setGainBonus() {
    final now = DateTime.now().millisecondsSinceEpoch;
    rlfPrefsPog.setInt('timeBonusGained', now);
    emit(state.copyWith(
      isGainBonus: true,
      score: state.score + 1000,
      timeBonusGained: now,
    ));
  }

  void addScore(int score) {
    rlfPrefsPog.setInt('score', score + state.score);
    emit(state.copyWith(score: score + state.score));
  }

  void tryBuyTrampoline() {
    if (state.score <= 500) throw Exception();
    rlfPrefsPog.setInt('score', state.score - 500);
    rlfPrefsPog.setInt('trampolineCount', state.trampolineCount + 1);
    emit(state.copyWith(score: state.score - 500, trampolineCount: state.trampolineCount + 1));
  }

  void tryBuyScoreMultiplier() {
    if (state.score <= 500) throw Exception();
    rlfPrefsPog.setInt('score', state.score - 500);
    rlfPrefsPog.setInt('scoreMultiplierCount', state.scoreMultiplierCount + 1);
    emit(state.copyWith(score: state.score - 500, scoreMultiplierCount: state.scoreMultiplierCount + 1));
  }

  void useTrampoline() {
    rlfPrefsPog.setInt('trampolineCount', state.trampolineCount - 1);
    emit(state.copyWith(trampolineCount: state.trampolineCount - 1));
  }

  void useScoreMultiplier() {
    rlfPrefsPog.setInt('scoreMultiplierCount', state.scoreMultiplierCount - 1);
    emit(state.copyWith(scoreMultiplierCount: state.scoreMultiplierCount - 1));
  }

  void tryBuyImage(String image, int price) {
    if (state.score <= price) throw Exception();
    rlfPrefsPog.setInt('score', state.score - price);
    rlfPrefsPog.setStringList('boughtImages', [...state.boughtImages, image]);
    emit(state.copyWith(score: state.score - price, boughtImages: [...state.boughtImages, image]));
  }

  void tryEquipBall(String image) {
    if (state.ballImage == image) throw Exception();
    rlfPrefsPog.setString('ballImage', image);
    emit(state.copyWith(ballImage: image));
  }

  void tryEquipAvatar(String image) {
    if (state.avatarImage == image) throw Exception();
    rlfPrefsPog.setString('avatarImage', image);
    emit(state.copyWith(avatarImage: image));
  }

  void setSound(bool sound) {
    emit(state.copyWith(sound: sound));
  }
}

class RLFAppStatePog {
  const RLFAppStatePog({
    required this.name,
    required this.score,
    required this.trampolineCount,
    required this.scoreMultiplierCount,
    required this.ballImage,
    required this.avatarImage,
    required this.boughtImages,
    required this.sound,
    required this.isGainBonus,
    required this.timeBonusGained,
  });
  final String name;
  final int score;
  final int trampolineCount;
  final int scoreMultiplierCount;
  final String ballImage;
  final String avatarImage;
  final List<String> boughtImages;
  final bool sound;
  final bool isGainBonus;
  final int? timeBonusGained;

  bool isImageBought(String image) => boughtImages.contains(image);

  bool isBallEquipped(String image) => image == ballImage;

  bool isAvatarEquipped(String image) => image == avatarImage;

  RLFAppStatePog copyWith({
    String? name,
    int? score,
    int? trampolineCount,
    int? scoreMultiplierCount,
    String? ballImage,
    String? avatarImage,
    List<String>? boughtImages,
    bool? sound,
    bool? isGainBonus,
    int? timeBonusGained,
  }) {
    return RLFAppStatePog(
      name: name ?? this.name,
      score: score ?? this.score,
      trampolineCount: trampolineCount ?? this.trampolineCount,
      scoreMultiplierCount: scoreMultiplierCount ?? this.scoreMultiplierCount,
      ballImage: ballImage ?? this.ballImage,
      avatarImage: avatarImage ?? this.avatarImage,
      boughtImages: boughtImages ?? this.boughtImages,
      sound: sound ?? this.sound,
      isGainBonus: isGainBonus ?? this.isGainBonus,
      timeBonusGained: timeBonusGained ?? this.timeBonusGained,
    );
  }
}
