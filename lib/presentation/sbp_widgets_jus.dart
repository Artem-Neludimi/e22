import 'dart:ui';

import 'package:e22/core/extensions/rlf_context_extensions_pog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:e22/core/assets/gen/assets.gen.dart';
import 'package:gradient_borders/gradient_borders.dart';

import 'rlf_settings_pog.dart';
import 'rlf_shop_pog.dart';
import 'sbp_menu_jus.dart';

class RLFAppButtonPOG extends StatelessWidget {
  const RLFAppButtonPOG({
    super.key,
    required this.child,
    this.color,
    this.onPressed,
  });
  final Widget child;
  final Color? color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.isSE ? 55 : 70,
      width: double.infinity,
      child: CupertinoButton(
        borderRadius: BorderRadius.circular(44),
        color: color ?? const Color.fromRGBO(66, 182, 70, 1),
        disabledColor: color?.withOpacity(0.5) ?? const Color.fromRGBO(66, 182, 70, 0.5),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

class RLFGameButtonsPOG extends StatelessWidget {
  const RLFGameButtonsPOG({
    super.key,
    this.leftOnPressed,
    this.rightOnPressed,
    this.trampolineOnPressed,
    this.boostOnPressed,
    this.haveTrampoline = true,
    this.haveMultiplier = true,
  });
  final VoidCallback? leftOnPressed;
  final VoidCallback? rightOnPressed;
  final VoidCallback? trampolineOnPressed;
  final VoidCallback? boostOnPressed;
  final bool haveTrampoline;
  final bool haveMultiplier;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        children: [
          // RLFRoundButtonPOG(
          //   onPressed: leftOnPressed,
          //   radius: (constraints.maxWidth - 72) / 4,
          //   child: Assets.images.rlfLeftPog.image(),
          // ),
          const SizedBox(width: 24),
          // RLFRoundButtonPOG(
          //   onPressed: haveTrampoline ? trampolineOnPressed : null,
          //   radius: (constraints.maxWidth - 72) / 4,
          //   color: Color.fromRGBO(66, 182, 70, haveTrampoline ? 1 : 0.2),
          //   child: Assets.images.rlfTrampolinePog.image(),
          // ),
          const SizedBox(width: 24),
          RLFRoundButtonPOG(
            onPressed: haveMultiplier ? boostOnPressed : null,
            radius: (constraints.maxWidth - 72) / 4,
            color: Color.fromRGBO(66, 182, 70, haveMultiplier ? 1 : 0.2),
            child: Center(
              child: Text(
                'X2',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 26),
              ),
            ),
          ),
          const SizedBox(width: 24),
          // RLFRoundButtonPOG(
          //   onPressed: rightOnPressed,
          //   radius: (constraints.maxWidth - 72) / 4,
          //   child: Assets.images.rlfRightPog.image(),
          // ),
        ],
      );
    });
  }
}

class RLFRoundButtonPOG extends StatelessWidget {
  const RLFRoundButtonPOG({
    super.key,
    required this.onPressed,
    required this.radius,
    this.color,
    required this.child,
  });

  final VoidCallback? onPressed;
  final double radius;
  final Color? color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: onPressed,
      child: Ink(
        height: radius,
        width: radius,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color ?? const Color.fromRGBO(42, 46, 131, 1),
        ),
        child: child,
      ),
    );
  }
}

class SbpBottomNavigationBarJus extends StatelessWidget {
  const SbpBottomNavigationBarJus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isMenu = context.findAncestorWidgetOfExactType<SbpMenuJus>() != null;
    final isShop = context.findAncestorWidgetOfExactType<RLFShopPog>() != null;
    final isSettings = context.findAncestorWidgetOfExactType<RLFSettingsPog>() != null;
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
          onTap: (value) {},
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          selectedLabelStyle: context.sourceSans(size: 14),
          unselectedLabelStyle: context.sourceSans(size: 14),
          showUnselectedLabels: true,
          currentIndex: isMenu
              ? 0
              : isShop
                  ? 1
                  : isSettings
                      ? 2
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
    required this.text,
  });
  final VoidCallback? onPressed;
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
          decoration: const BoxDecoration(
            gradient: SweepGradient(
              center: Alignment.bottomLeft,
              colors: _sbpGradientColorsJus,
            ),
            border: GradientBoxBorder(
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
  SbpAppBarJus({super.key})
      : super(
          preferredSize: const Size.fromHeight(80),
          child: Container(
            decoration: const BoxDecoration(
              gradient: SweepGradient(
                center: Alignment(1, -1.05),
                colors: _sbpGradientColorsJus,
              ),
            ),
          ),
        );
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
