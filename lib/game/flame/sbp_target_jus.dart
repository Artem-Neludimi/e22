import 'package:flame/components.dart';

import '../../core/assets/gen/assets.gen.dart';
import 'sbp_game_jus.dart';

class SbpTargetJus extends SpriteComponent with HasGameRef<SbpFlameGameJus> {
  static const double _size = 40;

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(Assets.images.sbpTargetJus.path);
    size = Vector2.all(_size);
    anchor = Anchor.center;
    return super.onLoad();
  }
}
