import 'package:e22/presentation/sbp_splash_jus.dart';
import 'package:e22/presentation/sbp_widgets_jus.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../game/flutter/sbp_game_screen_jus.dart';
import '../../presentation/sbp_menu_jus.dart';
import '../../presentation/sbp_onboarding_jus.dart';
import '../../presentation/sbp_settings_jus.dart';
import '../../presentation/sbp_shop_jus.dart';
import '../../presentation/sbp_tasks_jus.dart';
import '../../presentation/sbp_terms_of_use_jus.dart';

final _routerKey = GlobalKey<NavigatorState>();
final _menuKey = GlobalKey<NavigatorState>();

const _menuBottomNavigationBar = SbpBottomNavigationBarJus();

final GoRouter sbpRouterJus = GoRouter(
  navigatorKey: _routerKey,
  routes: [
    GoRoute(
      parentNavigatorKey: _routerKey,
      path: SbpRoutesJus.sbpSplashJus.path,
      builder: (context, state) => const SbpSplashScreenJus(),
    ),
    GoRoute(
      parentNavigatorKey: _routerKey,
      path: SbpRoutesJus.termsOfUse.path,
      builder: (context, state) => const SbpTermsOfUseScreenJus(),
    ),
    GoRoute(
      parentNavigatorKey: _routerKey,
      path: SbpRoutesJus.onboarding.path,
      builder: (context, state) => const SbpOnboardingJus(),
    ),
    ShellRoute(
      parentNavigatorKey: _routerKey,
      navigatorKey: _menuKey,
      pageBuilder: (context, state, child) => NoTransitionPage(child: child),
      routes: [
        GoRoute(
          path: SbpRoutesJus.menu.path,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SbpMenuJus(bottomNavigationBar: _menuBottomNavigationBar),
          ),
        ),
        GoRoute(
          path: SbpRoutesJus.tasks.path,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SbpTasksJus(bottomNavigationBar: _menuBottomNavigationBar),
          ),
        ),
        GoRoute(
          path: SbpRoutesJus.shop.path,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SbpShopJus(bottomNavigationBar: _menuBottomNavigationBar),
          ),
        ),
        GoRoute(
          path: SbpRoutesJus.settings.path,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SbpSettingsJus(bottomNavigationBar: _menuBottomNavigationBar),
          ),
        ),
      ],
    ),
    GoRoute(
      parentNavigatorKey: _routerKey,
      path: SbpRoutesJus.game.path,
      builder: (context, state) {
        if (state.extra is int) {
          return SbpGameScreenJus(
            index: state.extra as int,
          );
        }
        throw Exception();
      },
    ),
  ],
);

enum SbpRoutesJus {
  sbpSplashJus('/'),
  termsOfUse('/sbp-terms-of-use-jus'),
  onboarding('/sbp-onboarding-jus'),
  menu('/sbp-menu-jus'),
  tasks('/sbp-tasks-jus'),
  shop('/sbp-shop-jus'),
  settings('/sbp-settings-jus'),
  game('/sbp-game-jus'),
  ;

  const SbpRoutesJus(this.path);

  final String path;
}

extension SbpAppRouteNavigationJus on SbpRoutesJus {
  void go(BuildContext context, {extra}) => context.go(path, extra: extra);

  Future<T?> push<T>(BuildContext context, {extra}) => context.push<T>(path, extra: extra);
}
