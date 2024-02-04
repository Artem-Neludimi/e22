import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'sbp_flame_game_jus.dart';

class SbpLevelBoundariesJus extends RectangleComponent with HasGameRef<SbpFlameGameJus> {
  static const double _size = 270;
  @override
  FutureOr<void> onLoad() {
    position = Vector2(
      gameRef.size.x / 2 - _size / 2,
      gameRef.size.y / 2 - _size / 2,
    );
    size = Vector2.all(_size);
    paint = Paint()..color = const Color(0x00000000);

    _addingLevelHitBox();

    return super.onLoad();
  }

  void _addingLevelHitBox() {
    _level2Hitbox();
  }

  _level2Hitbox() {
    final paint = Paint()
      ..color = const Color(0x00000000)
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
          1,
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
          1,
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
          1,
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
          1,
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
          1,
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
          1,
          segment * 3,
        ),
      )
        ..paint = paint
        ..renderShape = true,
    ]);
  }
}
