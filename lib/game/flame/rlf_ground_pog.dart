import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'sbp_flame_game_jus.dart';

class RLFGroundPOG extends SpriteComponent with HasGameRef<SbpFlameGameJus> {
  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('Assets.images.rlfGroundPog.path');
    sprite!.srcSize.x = gameRef.size.x;
    position = Vector2(
      0,
      gameRef.size.y - 130,
    );
    add(RectangleHitbox());
    return super.onLoad();
  }
}
