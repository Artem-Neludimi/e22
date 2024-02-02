import 'dart:async';
import 'dart:ui';

import 'package:e22/game/rlf_game_bloc_pog.dart';
import 'package:e22/logic/rlf_app_cubit_pog.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'rlf_world_pog.dart';

class RLFFlameGamePog extends FlameGame with HasCollisionDetection {
  final RLFGameBlocPOG bloc;
  final RLFAppCubitPog appCubit;
  RLFFlameGamePog(this.bloc, this.appCubit) : super(world: RLFWorldPog());

  late final bool isSE;

  @override
  Color backgroundColor() => const Color.fromRGBO(13, 12, 80, 1);

  @override
  FutureOr<void> onLoad() {
    images.prefix = '';
    isSE = size.x < 400;
    camera = CameraComponent(world: world);
    camera.moveTo(Vector2(size.x / 2, size.y / 2));
    return super.onLoad();
  }
}
