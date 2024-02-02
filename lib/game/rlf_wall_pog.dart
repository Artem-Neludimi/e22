import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../gen/assets.gen.dart';
import 'rlf_flame_game_pog.dart';

class RLFWallPog extends SpriteComponent with HasGameRef<RLFFlameGamePog> {
  final bool isLeft;
  final double posY;
  RLFWallPog(this.isLeft, this.posY) : super(priority: 1);

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(Assets.images.rlfWallPog.path);
    position = Vector2(
      isLeft ? 0 : gameRef.size.x - sprite!.image.width,
      gameRef.isSE ? posY - 779 : posY,
    );
    if (!gameRef.isSE) {
      size = Vector2(
        sprite!.image.width.toDouble(),
        gameRef.size.y - 130,
      );
    }
    add(RectangleHitbox());
    return super.onLoad();
  }
}
