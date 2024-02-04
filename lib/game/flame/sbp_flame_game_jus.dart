import 'dart:async';

import 'package:e22/game/logic/rlf_game_bloc_pog.dart';
import 'package:e22/logic/rlf_app_cubit_pog.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'sbp_world_jus.dart';
import 'sbp_background_jus.dart';

class SbpFlameGameJus extends FlameGame with HasCollisionDetection {
  final RLFGameBlocPOG bloc;
  final RLFAppCubitPog appCubit;
  SbpFlameGameJus(this.bloc, this.appCubit) : super(world: SbpWorldJus());

  late final bool isSE;

  @override
  FutureOr<void> onLoad() {
    images.prefix = '';
    isSE = size.x < 400;
    add(Background());
    camera = CameraComponent(world: world);
    camera.moveTo(Vector2(size.x / 2, size.y / 2));
    return super.onLoad();
  }
}
