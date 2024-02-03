import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_bloc/flame_bloc.dart';

import '../logic/rlf_game_bloc_pog.dart';
import 'sbp_flame_game_jus.dart';
import 'rlf_ground_pog.dart';
import 'rlf_saw_pog.dart';
import 'rlf_wall_pog.dart';
import 'rlf_world_pog.dart';

class RLFBallPog extends SpriteComponent
    with HasGameRef<SbpFlameGameJus>, HasWorldReference<RLFWorldPog>, CollisionCallbacks {
  static const double _gravity = 8;
  static const double _inertia = 1.5;
  static const double _groundColl = -400;
  static const double _jumpX = 100;
  static const double _jumpY = -300;
  static const double _jumpYTrampolining = -3000;
  static const double _cameraOffset = 200;

  Vector2 direction = Vector2(0, 0);
  bool playing = true;
  bool _invincible = false;

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(gameRef.appCubit.state.ballImage);
    position = Vector2(
      gameRef.size.x / 2,
      gameRef.size.y - sprite!.image.height / 2 - 130,
    );
    anchor = Anchor.center;
    size = Vector2.all(gameRef.isSE ? 55 : 66);
    add(CircleHitbox());
    addAll([
      FlameBlocListener<RLFGameBlocPOG, RLFGameStatePOG>(
        bloc: gameRef.bloc,
        listenWhen: (previousState, newState) => newState.jumpLeft || newState.jumpRight,
        onNewState: (state) {
          direction.x = state.jumpLeft ? -_jumpX : _jumpX;
          if (direction.y > _jumpY) direction.y = _jumpY;
          if (gameRef.appCubit.state.sound) {
            FlameAudio.play('rlf_kick_pog.mp3');
          }
        },
      ),
      FlameBlocListener<RLFGameBlocPOG, RLFGameStatePOG>(
        bloc: gameRef.bloc,
        listenWhen: (previousState, newState) => previousState.pause != newState.pause,
        onNewState: (state) {
          playing = !state.pause;
        },
      ),
      FlameBlocListener<RLFGameBlocPOG, RLFGameStatePOG>(
        bloc: gameRef.bloc,
        listenWhen: (previousState, newState) => newState.gameOver,
        onNewState: (state) {
          playing = false;
        },
      ),
      FlameBlocListener<RLFGameBlocPOG, RLFGameStatePOG>(
        bloc: gameRef.bloc,
        listenWhen: (previousState, newState) => previousState.gameOver && !newState.gameOver,
        onNewState: (state) async {
          final center = gameRef.camera.visibleWorldRect.center;
          position = Vector2(center.dx, center.dy);
          direction = Vector2.zero();
          playing = true;
          _invincible = true;
          await Future<void>.delayed(const Duration(milliseconds: 5000));
          _invincible = false;
        },
      ),
      FlameBlocListener<RLFGameBlocPOG, RLFGameStatePOG>(
        bloc: gameRef.bloc,
        listenWhen: (previousState, newState) => previousState.isTrampolining == false && newState.isTrampolining,
        onNewState: (state) async {
          direction.y = _jumpYTrampolining;
          _invincible = true;
          await Future<void>.delayed(const Duration(milliseconds: 5000));
          _invincible = false;
        },
      ),
    ]);
    super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!playing) return;
    _mangePosition(dt);
    _manageCameraSawsScore();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) async {
    if (!playing) return;
    if (other is RLFGroundPOG) {
      direction.y = _groundColl;
    }
    if (other is RLFWallPog) {
      direction.x = other.isLeft ? _jumpX : -_jumpX;
    }
    if (other is RLFSawPOG) {
      if (_invincible) return;
      gameRef.bloc.add(const RLFGameOverPOG());
    }
    super.onCollision(intersectionPoints, other);
  }

  void _mangePosition(double dt) {
    //y
    direction.y += _gravity;

    //x
    if (direction.x > 0) {
      direction.x = max(direction.x - _inertia, 0);
    } else if (direction.x < 0) {
      direction.x = min(direction.x + _inertia, 0);
    }

    //moving
    position = position + direction * dt;

    //watch if ball is out of view
    final bottom = gameRef.camera.visibleWorldRect.bottom;
    if (position.y > bottom && position.y < gameRef.size.y - 400) {
      gameRef.bloc.add(const RLFGameOverPOG());
    }
  }

  void _manageCameraSawsScore() {
    final rect = gameRef.camera.visibleWorldRect;

    if (position.y < rect.center.dy - _cameraOffset) {
      _followCamera();
      _addingSaws();
      _addingScore(rect.top);
    }
  }

  void _followCamera() {
    gameRef.camera.follow(
      PositionComponent(
        position: Vector2(
          gameRef.size.x / 2,
          position.y + _cameraOffset,
        ),
      ),
    );
  }

  void _addingSaws() {
    final chance = Random().nextInt(100) < 1;
    if (chance) {
      final rect = gameRef.camera.visibleWorldRect;
      final randomX = Random().nextDouble() * (rect.width) + rect.left;
      world.add(
        RLFSawPOG(
          position: Vector2(
            randomX,
            rect.top - 100,
          ),
        ),
      );
    }
  }

  void _addingScore(double y) {
    gameRef.bloc.add(RLFGameAddScorePOG(y));
  }
}
