import 'package:e22/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SbpBonusCubitJus extends Cubit<SbpBonusStateJus> {
  static const _hour24InMilliseconds = 8.64e+7;

  SbpBonusCubitJus() : super(const SbpBonusStateJus());
  void init() {
    final bonusUnixTime = sbpPrefsJus.getInt('bonusUnixTime');
    final now = DateTime.now().millisecondsSinceEpoch;
    if (bonusUnixTime == null || bonusUnixTime + _hour24InMilliseconds < now) {
      emit(state.copyWith(showBonus: true));
    }
  }

  void setBonusTime() {
    final now = DateTime.now();
    sbpPrefsJus.setInt('bonusUnixTime', now.millisecondsSinceEpoch);
    emit(state.copyWith(time: '24:00', showBonus: false));
  }
}

class SbpBonusStateJus {
  const SbpBonusStateJus({
    this.time = '24:00',
    this.showBonus = false,
  });
  final String time;
  final bool showBonus;

  SbpBonusStateJus copyWith({
    String? time,
    bool? showBonus,
  }) {
    return SbpBonusStateJus(
      time: time ?? this.time,
      showBonus: showBonus ?? this.showBonus,
    );
  }
}
