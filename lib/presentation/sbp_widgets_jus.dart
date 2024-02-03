import 'dart:ui';

import 'package:e22/core/extensions/rlf_context_extensions_pog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:e22/core/assets/gen/assets.gen.dart';
import 'package:gradient_borders/gradient_borders.dart';

import '../main.dart';
import 'rlf_menu_pog.dart';
import 'rlf_settings_pog.dart';
import 'rlf_shop_pog.dart';

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

class RLFBottomNavigationBarPOG extends StatelessWidget {
  const RLFBottomNavigationBarPOG({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isMenu = context.findAncestorWidgetOfExactType<RLFMenuPog>() != null;
    final isShop = context.findAncestorWidgetOfExactType<RLFShopPog>() != null;
    final isSettings = context.findAncestorWidgetOfExactType<RLFSettingsPog>() != null;
    return BottomNavigationBar(
      onTap: (value) {
        switch (value) {
          case 0:
            if (!isMenu) {
              _noTransitionAnimation(context, const RLFMenuPog(bottomNavigationBar: bottomNavigationBar));
            }

          case 1:
            if (!isShop) {
              _noTransitionAnimation(context, const RLFShopPog(bottomNavigationBar: bottomNavigationBar));
            }

          case 2:
            if (!isSettings) {
              _noTransitionAnimation(context, const RLFSettingsPog(bottomNavigationBar: bottomNavigationBar));
            }
        }
      },
      backgroundColor: const Color.fromRGBO(42, 46, 131, 1),
      selectedItemColor: const Color.fromRGBO(66, 182, 70, 1),
      unselectedItemColor: Colors.white,
      selectedFontSize: 16,
      unselectedFontSize: 16,
      currentIndex: isMenu
          ? 0
          : isShop
              ? 1
              : isSettings
                  ? 2
                  : 0,
      elevation: 0,
      items: const [
        // BottomNavigationBarItem(
        //   icon: Padding(
        //     padding: const EdgeInsets.all(4),
        //     child: Assets.images.rlfBallIconWhitePog.image(),
        //   ),
        //   activeIcon: Padding(
        //     padding: const EdgeInsets.all(4),
        //     child: Assets.images.rlfBallIconGreenPog.image(),
        //   ),
        //   label: 'Game',
        // ),
        // BottomNavigationBarItem(
        //   icon: Padding(
        //     padding: const EdgeInsets.all(4),
        //     child: Assets.images.rlfShopIconWhitePog.image(),
        //   ),
        //   activeIcon: Padding(
        //     padding: const EdgeInsets.all(4),
        //     child: Assets.images.rlfShopIconGreenPog.image(),
        //   ),
        //   label: 'Shop',
        // ),
        // BottomNavigationBarItem(
        //   icon: Padding(
        //     padding: const EdgeInsets.all(4),
        //     child: Assets.images.rlfSettingsIconWhitePog.image(),
        //   ),
        //   activeIcon: Padding(
        //     padding: const EdgeInsets.all(4),
        //     child: Assets.images.rlfSettingsIconGreenPog.image(),
        //   ),
        //   label: 'Settings',
        // ),
      ],
    );
  }
}

Future<void> _noTransitionAnimation(BuildContext context, Widget screen) async {
  await Navigator.of(context).pushReplacement(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
  );
}

class SbpButtonJus extends StatefulWidget {
  const SbpButtonJus({
    super.key,
    this.onPressed,
    this.child,
  });
  final VoidCallback? onPressed;
  final Widget? child;

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
          height: context.isSE ? 55 : 70,
          decoration: const BoxDecoration(
            gradient: SweepGradient(
              center: Alignment.bottomLeft,
              colors: [
                Color.fromRGBO(227, 164, 85, 1),
                Color.fromRGBO(246, 219, 166, 1),
                Color.fromRGBO(255, 235, 195, 1),
                Color.fromRGBO(240, 190, 121, 1),
                Color.fromRGBO(143, 101, 59, 1),
                Color.fromRGBO(131, 80, 48, 1),
                Color.fromRGBO(186, 127, 59, 1),
                Color.fromRGBO(238, 188, 112, 1),
                Color.fromRGBO(106, 62, 40, 1),
              ],
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
          child: Center(child: widget.child),
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
