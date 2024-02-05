import 'dart:async';

import 'package:e22/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SbpBonusCubitJus extends Cubit<SbpBonusStateJus> {
  static const int _hour24InMilliseconds = 86400000;

  SbpBonusCubitJus() : super(const SbpBonusStateJus());

  StreamSubscription? _subscription;

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  void init() {
    final bonusUnixTime = sbpPrefsJus.getInt('bonusUnixTime');
    final now = DateTime.now().millisecondsSinceEpoch;
    if (bonusUnixTime == null || bonusUnixTime + _hour24InMilliseconds < now) {
      emit(state.copyWith(showBonus: true));
    }
    _subscription = Stream.periodic(const Duration(milliseconds: 250), (x) => x).listen((_) {
      emit(state.copyWith(time: _getTime()));
    });
  }

  void setBonusTime() {
    final now = DateTime.now();
    sbpPrefsJus.setInt('bonusUnixTime', now.millisecondsSinceEpoch);
    emit(state.copyWith(time: '24:00', showBonus: false));
  }

  String _getTime() {
    final bonusTimeUnix = sbpPrefsJus.getInt('bonusUnixTime');
    if (bonusTimeUnix == null) return '24:00';
    final bonusTimeDateTime = DateTime.fromMillisecondsSinceEpoch(bonusTimeUnix);
    final timeDifference = bonusTimeDateTime.add(const Duration(days: 1)).difference(DateTime.now());
    final hours = (timeDifference.inHours % 24).toString().padLeft(2, '0');
    final minutes = (timeDifference.inMinutes % 60).toString().padLeft(2, '0');
    return '$hours:$minutes';
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
