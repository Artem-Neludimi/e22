import 'package:flame/components.dart';

import 'sbp_flame_game_jus.dart';
import 'sbp_level_boundaries_jus.dart';

class SbpWorldJus extends World with HasGameRef<SbpFlameGameJus>, HasCollisionDetection {
  @override
  Future<void> onLoad() async {
    add(SbpLevelBoundariesJus());
    return super.onLoad();
  }
}
