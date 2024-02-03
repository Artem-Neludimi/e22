import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class RLFGameEventPOG {
  const RLFGameEventPOG();
}

class RLFGameJumpLeftPOG extends RLFGameEventPOG {
  const RLFGameJumpLeftPOG();
}

class RLFGameJumpRightPOG extends RLFGameEventPOG {
  const RLFGameJumpRightPOG();
}

class RLFGameAddScorePOG extends RLFGameEventPOG {
  const RLFGameAddScorePOG(this.height);
  final double height;
}

class RLFGamePausePOG extends RLFGameEventPOG {
  const RLFGamePausePOG();
}

class RLFGameResumePOG extends RLFGameEventPOG {
  const RLFGameResumePOG();
}

class RLFGameOverPOG extends RLFGameEventPOG {
  const RLFGameOverPOG();
}

class RLFGameRestartPOG extends RLFGameEventPOG {
  const RLFGameRestartPOG();
}

class RLFGameTrampolinePOG extends RLFGameEventPOG {
  const RLFGameTrampolinePOG();
}

class RLFGameMultiplierPOG extends RLFGameEventPOG {
  const RLFGameMultiplierPOG();
}

class RLFGameBlocPOG extends Bloc<RLFGameEventPOG, RLFGameStatePOG> {
  RLFGameBlocPOG() : super(const RLFGameStatePOG()) {
    on<RLFGameEventPOG>(
      (event, emit) => switch (event) {
        RLFGameJumpLeftPOG() => _onJumpLeft(emit),
        RLFGameJumpRightPOG() => _onJumpRight(emit),
        RLFGamePausePOG() => _onGamePause(emit),
        RLFGameAddScorePOG() => _onAddScore(event, emit),
        RLFGameResumePOG() => _onGameResume(emit),
        RLFGameOverPOG() => _onGameOver(emit),
        RLFGameRestartPOG() => _onGameRestart(emit),
        RLFGameTrampolinePOG() => _onGameTrampoline(emit),
        RLFGameMultiplierPOG() => _onGameMultiplier(emit),
      },
      transformer: droppable(),
    );
  }

  Future<void> _onJumpLeft(Emitter<RLFGameStatePOG> emit) async {
    emit(state.copyWith(jumpLeft: true));
    emit(state.copyWith(jumpLeft: false));
  }

  Future<void> _onJumpRight(Emitter<RLFGameStatePOG> emit) async {
    emit(state.copyWith(jumpRight: true));
    emit(state.copyWith(jumpRight: false));
  }

  Future<void> _onGamePause(Emitter<RLFGameStatePOG> emit) async {
    emit(state.copyWith(pause: true));
  }

  Future<void> _onAddScore(RLFGameAddScorePOG event, Emitter<RLFGameStatePOG> emit) async {
    if (event.height > 0) return;
    emit(state.copyWith(score: (-event.height ~/ 25) + state.scoreMultiplied));
  }

  Future<void> _onGameResume(Emitter<RLFGameStatePOG> emit) async {
    emit(state.copyWith(pause: false));
  }

  Future<void> _onGameOver(Emitter<RLFGameStatePOG> emit) async {
    emit(state.copyWith(gameOver: true));
  }

  Future<void> _onGameRestart(Emitter<RLFGameStatePOG> emit) async {
    emit(state.copyWith(gameOver: false));
  }

  Future<void> _onGameTrampoline(Emitter<RLFGameStatePOG> emit) async {
    emit(state.copyWith(isTrampolining: true, didUseTrampoline: true));
  }

  Future<void> _onGameMultiplier(Emitter<RLFGameStatePOG> emit) async {
    emit(
      state.copyWith(
        didUseScoreMultiplier: true,
        scoreMultiplied: state.score,
        score: state.score * 2,
      ),
    );
  }
}

class RLFGameStatePOG {
  const RLFGameStatePOG({
    this.jumpLeft = false,
    this.jumpRight = false,
    this.pause = false,
    this.gameOver = false,
    this.score = 0,
    this.scoreMultiplied = 0,
    this.isTrampolining = false,
    this.didUseTrampoline = false,
    this.didUseScoreMultiplier = false,
  });

  final bool jumpLeft;
  final bool jumpRight;
  final bool pause;
  final bool gameOver;
  final int score;
  final int scoreMultiplied;
  final bool isTrampolining;
  final bool didUseTrampoline;
  final bool didUseScoreMultiplier;

  RLFGameStatePOG copyWith({
    bool? jumpLeft,
    bool? jumpRight,
    bool? pause,
    bool? gameOver,
    int? score,
    int? scoreMultiplied,
    bool? isTrampolining,
    bool? didUseTrampoline,
    bool? didUseScoreMultiplier,
  }) {
    return RLFGameStatePOG(
      jumpLeft: jumpLeft ?? this.jumpLeft,
      jumpRight: jumpRight ?? this.jumpRight,
      pause: pause ?? this.pause,
      gameOver: gameOver ?? this.gameOver,
      score: score ?? this.score,
      scoreMultiplied: scoreMultiplied ?? this.scoreMultiplied,
      isTrampolining: isTrampolining ?? this.isTrampolining,
      didUseTrampoline: didUseTrampoline ?? this.didUseTrampoline,
      didUseScoreMultiplier: didUseScoreMultiplier ?? this.didUseScoreMultiplier,
    );
  }
}
