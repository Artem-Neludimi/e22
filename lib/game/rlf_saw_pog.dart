import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../core/assets/gen/assets.gen.dart';
import 'rlf_flame_game_pog.dart';

class RLFSawPOG extends SpriteComponent with HasGameRef<RLFFlameGamePog> {
  RLFSawPOG({super.position});

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(Assets.images.rlfSawPog.path);
    size = Vector2(70, 70);
    anchor = Anchor.center;
    add(CircleHitbox());

    return super.onLoad();
  }
}
