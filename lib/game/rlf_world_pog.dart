import 'dart:math';

import 'package:e22/game/rlf_flame_game_pog.dart';
import 'package:e22/game/rlf_saw_pog.dart';
import 'package:flame/components.dart';

import 'rlf_ball_pog.dart';
import 'rlf_ground_pog.dart';
import 'rlf_wall_pog.dart';

class RLFWorldPog extends World with HasGameRef<RLFFlameGamePog>, HasCollisionDetection {
  static const _wallHeight = 722;
  double _lastWall = -722;

  late final RLFBallPog ball;

  @override
  Future<void> onLoad() async {
    addAll([
      RLFGroundPOG(),
      ball = RLFBallPog(),
      RLFWallPog(true, 0),
      RLFWallPog(false, 0),
    ]);
    _generatingInitialSaws();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (!ball.playing) return;
    _handleWalls();
    super.update(dt);
  }

  void _generatingInitialSaws() {
    final rect = gameRef.camera.visibleWorldRect;
    for (var i = 0; i < 5; i++) {
      add(
        RLFSawPOG(
          position: Vector2(
            (rect.left + (rect.width / 10) * i) + Random().nextInt(200) + 100,
            (rect.top + (rect.height / 9) * i) + Random().nextInt(200) + 100,
          ),
        ),
      );
    }
  }

  void _handleWalls() {
    if (gameRef.camera.visibleWorldRect.top - gameRef.size.y < _lastWall) {
      addAll([
        RLFWallPog(true, _lastWall),
        RLFWallPog(false, _lastWall),
      ]);
      _lastWall -= _wallHeight;
    }
  }
}
