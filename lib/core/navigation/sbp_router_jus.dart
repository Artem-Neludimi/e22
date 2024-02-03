import 'package:e22/presentation/sbp_splash_jus.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../presentation/sbp_terms_of_use_jus.dart';

final _routerKey = GlobalKey<NavigatorState>();

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
  ],
);

enum SbpRoutesJus {
  sbpSplashJus('/'),
  termsOfUse('/sbp-terms-of-use-jus'),
  ;

  const SbpRoutesJus(this.path);

  final String path;
}

extension SbpAppRouteNavigationJus on SbpRoutesJus {
  void go(BuildContext context, {extra}) => context.go(path, extra: extra);

  Future<T?> push<T>(BuildContext context, {extra}) => context.push<T>(path, extra: extra);
}
