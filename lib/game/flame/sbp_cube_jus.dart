import 'package:flame/components.dart';

import '../../core/assets/gen/assets.gen.dart';
import 'sbp_flame_game_jus.dart';

class SbpCubeJus extends SpriteComponent with HasGameRef<SbpFlameGameJus> {
  static const double _size = 45;
  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(Assets.images.sbpCubeJus.path);
    size = Vector2.all(_size);
    return super.onLoad();
  }
}
