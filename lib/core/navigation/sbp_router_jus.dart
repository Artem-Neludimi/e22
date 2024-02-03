import 'package:e22/presentation/sbp_splash_jus.dart';
import 'package:e22/presentation/sbp_widgets_jus.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../presentation/sbp_menu_jus.dart';
import '../../presentation/sbp_onboarding_jus.dart';
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
      builder: (context, state, child) => child,
      routes: [
        GoRoute(
          path: SbpRoutesJus.menu.path,
          builder: (context, state) => const SbpMenuJus(bottomNavigationBar: _menuBottomNavigationBar),
        ),
        GoRoute(
          path: SbpRoutesJus.tasks.path,
          builder: (context, state) => const Scaffold(bottomNavigationBar: _menuBottomNavigationBar),
        ),
        GoRoute(
          path: SbpRoutesJus.shop.path,
          builder: (context, state) => const Scaffold(bottomNavigationBar: _menuBottomNavigationBar),
        ),
        GoRoute(
          path: SbpRoutesJus.settings.path,
          builder: (context, state) => const Scaffold(bottomNavigationBar: _menuBottomNavigationBar),
        ),
      ],
    )
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
  ;

  const SbpRoutesJus(this.path);

  final String path;
}

extension SbpAppRouteNavigationJus on SbpRoutesJus {
  void go(BuildContext context, {extra}) => context.go(path, extra: extra);

  Future<T?> push<T>(BuildContext context, {extra}) => context.push<T>(path, extra: extra);
}
