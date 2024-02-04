import 'package:flame/components.dart';

import 'sbp_cube_jus.dart';
import 'sbp_game_jus.dart';
import 'sbp_level_boundaries_jus.dart';

class SbpWorldJus extends World with HasGameRef<SbpFlameGameJus>, HasCollisionDetection {
  late final SbpCubeJus cube;
  @override
  Future<void> onLoad() async {
    addAll([
      cube = SbpCubeJus(),
      SbpLevelBoundariesJus(),
    ]);
    return super.onLoad();
  }
}
