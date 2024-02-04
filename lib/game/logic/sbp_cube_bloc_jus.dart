import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class SbpCubeEventJus {
  const SbpCubeEventJus();
}

class SbpCubeStopEventJus extends SbpCubeEventJus {
  const SbpCubeStopEventJus();
}

class SbpCubeLeftEventJus extends SbpCubeEventJus {
  const SbpCubeLeftEventJus();
}

class SbpCubeRightEventJus extends SbpCubeEventJus {
  const SbpCubeRightEventJus();
}

class SbpCubeUpEventJus extends SbpCubeEventJus {
  const SbpCubeUpEventJus();
}

class SbpCubeDownEventJus extends SbpCubeEventJus {
  const SbpCubeDownEventJus();
}

class SbpCubeBlocJus extends Bloc<SbpCubeEventJus, SbpCubeStateJus> {
  SbpCubeBlocJus() : super(const SbpCubeStopJus()) {
    on<SbpCubeEventJus>(
      (event, emit) => switch (event) {
        SbpCubeStopEventJus() => _onStop(emit),
        SbpCubeLeftEventJus() => _onLeft(emit),
        SbpCubeRightEventJus() => _onRight(emit),
        SbpCubeUpEventJus() => _onUp(emit),
        SbpCubeDownEventJus() => _onDown(emit),
      },
      transformer: droppable(),
    );
  }

  Future<void> _onStop(Emitter<SbpCubeStateJus> emit) async {
    emit(const SbpCubeStopJus());
  }

  Future<void> _onLeft(Emitter<SbpCubeStateJus> emit) async {
    if (state is! SbpCubeStopJus) return;

    emit(const SbpCubeLeftJus());
  }

  Future<void> _onRight(Emitter<SbpCubeStateJus> emit) async {
    if (state is! SbpCubeStopJus) return;

    emit(const SbpCubeRightJus());
  }

  Future<void> _onUp(Emitter<SbpCubeStateJus> emit) async {
    if (state is! SbpCubeStopJus) return;

    emit(const SbpCubeUpJus());
  }

  Future<void> _onDown(Emitter<SbpCubeStateJus> emit) async {
    if (state is! SbpCubeStopJus) return;

    emit(const SbpCubeDownJus());
  }
}

sealed class SbpCubeStateJus {
  const SbpCubeStateJus();
}

class SbpCubeStopJus extends SbpCubeStateJus {
  const SbpCubeStopJus();
}

class SbpCubeLeftJus extends SbpCubeStateJus {
  const SbpCubeLeftJus();
}

class SbpCubeRightJus extends SbpCubeStateJus {
  const SbpCubeRightJus();
}

class SbpCubeUpJus extends SbpCubeStateJus {
  const SbpCubeUpJus();
}

class SbpCubeDownJus extends SbpCubeStateJus {
  const SbpCubeDownJus();
}
