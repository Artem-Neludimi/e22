import 'package:flutter_bloc/flutter_bloc.dart';

class SbpBonusCubitJus extends Cubit<SbpBonusStateJus> {
  SbpBonusCubitJus() : super(const SbpBonusStateJus());
  void init() {
    
  }
}

class SbpBonusStateJus {
  const SbpBonusStateJus({
    this.time = '24:00',
  });
  final String time;
}
