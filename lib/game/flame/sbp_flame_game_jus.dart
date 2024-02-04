import 'dart:async';
import 'dart:ui';

import 'package:e22/game/logic/sbp_cube_bloc_jus.dart';
import 'package:e22/logic/rlf_app_cubit_pog.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'sbp_world_jus.dart';

class SbpFlameGameJus extends FlameGame with HasCollisionDetection, VerticalDragDetector, HorizontalDragDetector {
  final SbpCubeBlocJus cubeBloc;
  final RLFAppCubitPog appCubit;
  SbpFlameGameJus(this.cubeBloc, this.appCubit) : super(world: SbpWorldJus());

  late final bool isSE;

  @override
  Color backgroundColor() => const Color(0x00000000);

  @override
  FutureOr<void> onLoad() {
    images.prefix = '';
    isSE = size.x < 400;
    camera = CameraComponent(world: world);
    camera.moveTo(Vector2(size.x / 2, size.y / 2));
    return super.onLoad();
  }

  @override
  void onVerticalDragEnd(DragEndInfo info) {
    if (info.velocity.y > 0) {
      cubeBloc.add(const SbpCubeDownEventJus());
    } else if (info.velocity.y < 0) {
      cubeBloc.add(const SbpCubeUpEventJus());
    }
  }

  @override
  void onHorizontalDragEnd(DragEndInfo info) {
    if (info.velocity.x > 0) {
      cubeBloc.add(const SbpCubeRightEventJus());
    } else if (info.velocity.x < 0) {
      cubeBloc.add(const SbpCubeLeftEventJus());
    }
  }
}
