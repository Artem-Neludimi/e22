import 'package:e22/presentation/rlf_splash_pog.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../presentation/rlf_onboarding_pog.dart';

final _routerKey = GlobalKey<NavigatorState>();
final _homeKey = GlobalKey<NavigatorState>();

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
      path: SbpRoutesJus.sbpOnboardingJus.path,
      builder: (context, state) => const RLFOnboardingPog(),
    ),
  ],
);

enum SbpRoutesJus {
  sbpSplashJus('/'),
  sbpOnboardingJus('/sbp-onboarding-jus'),
  ;

  const SbpRoutesJus(this.path);

  final String path;
}

extension SbpAppRouteNavigationJus on SbpRoutesJus {
  void go(BuildContext context, {extra}) => context.go(path, extra: extra);

  Future<T?> push<T>(BuildContext context, {extra}) => context.push<T>(path, extra: extra);
}
