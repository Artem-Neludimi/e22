import 'package:e22/game/flame/sbp_target_jus.dart';
import 'package:flame/components.dart';

import 'sbp_cube_jus.dart';
import 'sbp_game_jus.dart';
import 'sbp_level_boundaries_jus.dart';

class SbpWorldJus extends World with HasGameRef<SbpFlameGameJus>, HasCollisionDetection {
  late final SbpCubeJus cube;
  late final SbpTargetJus target;
  @override
  Future<void> onLoad() async {
    addAll([
      cube = SbpCubeJus(),
      target = SbpTargetJus(),
      SbpLevelBoundariesJus(),
    ]);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    final distance = (cube.position - target.position).distanceTo(Vector2.zero());
    if (distance < 3 && cube.direction == Vector2.zero()) {
      gameRef.gameConfigCubit.sbpSetWinJus();
    }
    super.update(dt);
  }
}
