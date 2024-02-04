import 'dart:async';
import 'dart:ui';

import 'package:e22/game/logic/sbp_game_config_cubit.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';

import 'sbp_game_jus.dart';
import 'sbp_world_jus.dart';

class SbpLevelBoundariesJus extends RectangleComponent
    with HasGameRef<SbpFlameGameJus>, HasWorldReference<SbpWorldJus> {
  static const double _size = 270;
  static const double _boundarySize = 1;
  @override
  FutureOr<void> onLoad() {
    position = Vector2(
      gameRef.size.x / 2 - _size / 2,
      gameRef.size.y / 2 - _size / 2,
    );
    size = Vector2.all(_size);
    paint = Paint()..color = const Color(0x00000000);
    _manageCubeInitialPosition();
    _addingLevelHitBox();
    _blocListener();
    return super.onLoad();
  }

  void _blocListener() {
    add(
      FlameBlocListener<SbpGameConfigCubit, SbpGameConfigState>(
        bloc: gameRef.gameConfigCubit,
        listenWhen: (previousState, newState) => previousState.restart == false && newState.restart == true,
        onNewState: (state) {
          _manageCubeInitialPosition();
          gameRef.gameConfigCubit.sbpResetRestartJus();
        },
      ),
    );
  }

  void _addingLevelHitBox() {
    _level2Hitbox();
  }

  void _manageCubeInitialPosition() {
    final cube = world.cube;
    cube.position = Vector2(
      gameRef.size.x / 2 - _size / 2 + 24,
      gameRef.size.y / 2 - _size / 6 + 24,
    );
  }

  void _level2Hitbox() {
    final paint = Paint()
      ..color = const Color.fromRGBO(185, 144, 87, 1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    const segment = _size / 6;

    addAll([
      RectangleHitbox(
        position: Vector2(
          0,
          segment * 2,
        ),
        size: Vector2(
          segment * 2,
          _boundarySize,
        ),
      )
        ..paint = paint
        ..renderShape = true,
      RectangleHitbox(
        position: Vector2(
          segment * 2,
          segment * 2,
        ),
        size: Vector2(
          _boundarySize,
          segment,
        ),
      )
        ..paint = paint
        ..renderShape = true,
      RectangleHitbox(
        position: Vector2(
          segment * 2,
          segment * 3,
        ),
        size: Vector2(
          segment * 4,
          _boundarySize,
        ),
      )
        ..paint = paint
        ..renderShape = true,
      RectangleHitbox(
        position: Vector2(
          segment * 6,
          segment * 3,
        ),
        size: Vector2(
          _boundarySize,
          segment * 2,
        ),
      )
        ..paint = paint
        ..renderShape = true,
      RectangleHitbox(
        position: Vector2(
          0,
          segment * 5,
        ),
        size: Vector2(
          segment * 6,
          _boundarySize,
        ),
      )
        ..paint = paint
        ..renderShape = true,
      RectangleHitbox(
        position: Vector2(
          0,
          segment * 2,
        ),
        size: Vector2(
          _boundarySize,
          segment * 3,
        ),
      )
        ..paint = paint
        ..renderShape = true,
    ]);
  }
}
