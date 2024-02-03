import 'package:e22/game/flame/sbp_flame_game_jus.dart';
import 'package:flame/components.dart';

import '../../core/assets/gen/assets.gen.dart';

class Background extends SpriteComponent with HasGameRef<SbpFlameGameJus> {
  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(Assets.images.sbpGameBgJus.path);
    sprite!.srcSize.x = gameRef.size.x;
    sprite!.srcSize.y = gameRef.size.y;
    return super.onLoad();
  }
}