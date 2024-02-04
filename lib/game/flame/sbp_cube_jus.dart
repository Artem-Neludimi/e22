import 'package:e22/game/logic/sbp_cube_bloc_jus.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';

import 'sbp_flame_game_jus.dart';
import 'sbp_level_boundaries_jus.dart';
import '../../core/assets/gen/assets.gen.dart';

class SbpCubeJus extends SpriteComponent with HasGameRef<SbpFlameGameJus>, CollisionCallbacks {
  static const double _size = 45;

  Vector2 direction = Vector2.zero();

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(Assets.images.sbpCubeJus.path);
    size = Vector2.all(_size);
    anchor = Anchor.center;
    add(RectangleHitbox(
      size: Vector2.all(_size + 5),
    )..renderShape = false);
    add(
      FlameBlocListener(
        bloc: gameRef.cubeBloc,
        onNewState: (state) {
          switch (state) {
            case SbpCubeStopJus():
              direction = Vector2.zero();
            case SbpCubeUpJus():
              direction.y = -100;
            case SbpCubeDownJus():
              direction.y = 100;
            case SbpCubeLeftJus():
              direction.x = -100;
            case SbpCubeRightJus():
              direction.x = 100;
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
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is SbpLevelBoundariesJus) {
      gameRef.cubeBloc.add(const SbpCubeStopEventJus());
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
