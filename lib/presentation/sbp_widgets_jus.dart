import 'dart:ui';

import 'package:e22/core/extensions/rlf_context_extensions_pog.dart';
import 'package:e22/core/navigation/sbp_router_jus.dart';
import 'package:e22/logic/rlf_app_cubit_pog.dart';
import 'package:e22/presentation/sbp_settings_jus.dart';
import 'package:e22/presentation/sbp_shop_jus.dart';
import 'package:e22/presentation/sbp_tasks_jus.dart';
import 'package:flutter/material.dart';

import 'package:e22/core/assets/gen/assets.gen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/gradient_borders.dart';

import 'sbp_menu_jus.dart';

class SbpBottomNavigationBarJus extends StatelessWidget {
  const SbpBottomNavigationBarJus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isMenu = context.findAncestorWidgetOfExactType<SbpMenuJus>() != null;
    final isTasks = context.findAncestorWidgetOfExactType<SbpTasksJus>() != null;
    final isShop = context.findAncestorWidgetOfExactType<SbpShopJus>() != null;
    final isSettings = context.findAncestorWidgetOfExactType<SbpSettingsJus>() != null;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(22),
        topRight: Radius.circular(22),
      ),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: SweepGradient(
            center: Alignment.bottomLeft,
            colors: _sbpGradientColorsJus,
          ),
        ),
        child: BottomNavigationBar(
          onTap: (value) {
            if (value == 0) {
              SbpRoutesJus.menu.go(context);
            } else if (value == 1) {
              SbpRoutesJus.tasks.go(context);
            } else if (value == 2) {
              SbpRoutesJus.shop.go(context);
            } else if (value == 3) {
              SbpRoutesJus.settings.go(context);
            }
          },
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          selectedLabelStyle: context.sourceSans(size: 14),
          unselectedLabelStyle: context.sourceSans(size: 14),
          showUnselectedLabels: true,
          currentIndex: isMenu
              ? 0
              : isTasks
                  ? 1
                  : isShop
                      ? 2
                      : isSettings
                          ? 3
                          : 0,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              activeIcon: Assets.svg.sbpMapJus.svg(),
              icon: Assets.svg.sbpMapJus.svg(color: Colors.black),
              label: 'Game Map',
            ),
            BottomNavigationBarItem(
              activeIcon: Assets.svg.sbpTasksJus.svg(),
              icon: Assets.svg.sbpTasksJus.svg(color: Colors.black),
              label: 'Tasks',
            ),
            BottomNavigationBarItem(
              activeIcon: Assets.svg.sbpShopJus.svg(),
              icon: Assets.svg.sbpShopJus.svg(color: Colors.black),
              label: 'Shop',
            ),
            BottomNavigationBarItem(
              activeIcon: Assets.svg.sbpSettingsJus.svg(),
              icon: Assets.svg.sbpSettingsJus.svg(color: Colors.black),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}

class SbpButtonJus extends StatefulWidget {
  const SbpButtonJus({
    super.key,
    this.onPressed,
    this.isBlack = false,
    required this.text,
  });
  final VoidCallback? onPressed;
  final bool isBlack;
  final String text;

  @override
  State<SbpButtonJus> createState() => _SbpButtonJusState();
}

class _SbpButtonJusState extends State<SbpButtonJus> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => setState(() => isPressed = true),
      onLongPressEnd: (_) {
        setState(() => isPressed = false);
        widget.onPressed?.call();
      },
      onTap: () async {
        setState(() => isPressed = !isPressed);
        await Future.delayed(const Duration(milliseconds: 100));
        setState(() => isPressed = !isPressed);
        widget.onPressed?.call();
      },
      child: AnimatedOpacity(
        opacity: isPressed ? 0.5 : 1,
        duration: const Duration(milliseconds: 100),
        child: Container(
          height: context.isSE ? 50 : 60,
          decoration: BoxDecoration(
            color: widget.isBlack ? const Color.fromARGB(255, 30, 30, 30) : null,
            gradient: widget.isBlack
                ? null
                : const SweepGradient(
                    center: Alignment.bottomLeft,
                    colors: _sbpGradientColorsJus,
                  ),
            border: const GradientBoxBorder(
              width: 2,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(224, 176, 104, 1),
                  Color.fromRGBO(91, 69, 37, 1),
                ],
              ),
            ),
          ),
          child: Center(
              child: Text(widget.text, style: context.inter(color: const Color.fromRGBO(221, 168, 95, 1), size: 33))),
        ),
      ),
    );
  }
}

class SbpBoardJus extends StatelessWidget {
  const SbpBoardJus({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(182, 128, 66, 0.7),
            border: GradientBoxBorder(
              width: 4,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(224, 176, 104, 1),
                  Color.fromRGBO(91, 69, 37, 1),
                ],
              ),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class SbpAppBarJus extends PreferredSize {
  final BuildContext context;
  SbpAppBarJus({super.key, required this.context})
      : super(
          preferredSize: const Size.fromHeight(55),
          child: Container(
            decoration: const BoxDecoration(
              gradient: SweepGradient(
                center: Alignment(1, -1.05),
                colors: _sbpGradientColorsJus,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SbpMoneyBoardJus(
                    money: context.watch<SbpAppCubitJus>().state.score.toString(),
                  ),
                ],
              ),
            ),
          ),
        );
}

class SbpMoneyBoardJus extends StatelessWidget {
  final String money;
  const SbpMoneyBoardJus({
    super.key,
    required this.money,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Assets.images.sbpBoardJus.image(),
        Positioned(
          top: 0,
          bottom: 0,
          left: 15,
          right: 40,
          child: Center(
            child: FittedBox(
              child: Text(
                money,
                style: context.sourceCode(
                  color: const Color.fromRGBO(224, 176, 104, 1),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

const _sbpGradientColorsJus = [
  Color.fromRGBO(227, 164, 85, 1),
  Color.fromRGBO(246, 219, 166, 1),
  Color.fromRGBO(255, 235, 195, 1),
  Color.fromRGBO(240, 190, 121, 1),
  Color.fromRGBO(143, 101, 59, 1),
  Color.fromRGBO(131, 80, 48, 1),
  Color.fromRGBO(186, 127, 59, 1),
  Color.fromRGBO(238, 188, 112, 1),
  Color.fromRGBO(106, 62, 40, 1),
];

class NotEnoughMoneyDialog extends StatelessWidget {
  const NotEnoughMoneyDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              Assets.images.sbpDialogJus.image(),
              Positioned(
                top: 65,
                left: 20,
                right: 20,
                child: Text(
                  'BUY LEVEL',
                  style: context.berlinSans(
                    size: 40,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Text(
                    'Not enough credits!',
                    textAlign: TextAlign.center,
                    style: context.sourceCode(size: 44),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 45,
                right: 45,
                child: SbpButtonJus(
                  isBlack: true,
                  text: 'Cancel',
                  onPressed: () {
                    context.pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
