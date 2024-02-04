import 'package:e22/game/logic/sbp_cube_bloc_jus.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';

import 'sbp_game_jus.dart';
import 'sbp_level_boundaries_jus.dart';
import '../../core/assets/gen/assets.gen.dart';
import 'sbp_target_jus.dart';

class SbpCubeJus extends SpriteComponent with HasGameRef<SbpFlameGameJus>, CollisionCallbacks {
  SbpCubeJus() : super(priority: 2);

  static const double _size = 45;
  static const double _speed = 300;
  static const double _speedCompensation = 7;

  Vector2 direction = Vector2.zero();

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(Assets.images.sbpCubeJus.path);
    size = Vector2.all(_size);
    anchor = Anchor.center;
    add(RectangleHitbox()..renderShape = false);
    add(
      FlameBlocListener(
        bloc: gameRef.cubeBloc,
        onNewState: (state) {
          switch (state) {
            case SbpCubeStopJus():
              direction = Vector2.zero();
            case SbpCubeUpJus():
              direction.y = -_speed;
            case SbpCubeDownJus():
              direction.y = _speed;
            case SbpCubeLeftJus():
              direction.x = -_speed;
            case SbpCubeRightJus():
              direction.x = _speed;
          }
        },
      ),
    );
    return super.onLoad();
  }

  @override
  void update(double dt) {
    position += direction * dt;
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is SbpLevelBoundariesJus) {
      final mid = (intersectionPoints.elementAt(0) + intersectionPoints.elementAt(1)) / 2;
      if (direction.y > 0) {
        position.y = mid.y - _size / 2 - _speedCompensation;
      } else if (direction.y < 0) {
        position.y = mid.y + _size / 2 + _speedCompensation;
      } else if (direction.x > 0) {
        position.x = mid.x - _size / 2 - _speedCompensation;
      } else if (direction.x < 0) {
        position.x = mid.x + _size / 2 + _speedCompensation;
      }
      gameRef.cubeBloc.add(const SbpCubeStopEventJus());
    }
    super.onCollision(intersectionPoints, other);
  }
}
