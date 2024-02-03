import 'package:e22/core/extensions/rlf_context_extensions_pog.dart';
import 'package:e22/logic/rlf_app_cubit_pog.dart';
import 'package:e22/presentation/rlf_nickname_pog.dart';
import 'package:e22/presentation/rlf_widgets_pog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'game/rlf_game_screen_pog.dart';
import 'presentation/rlf_menu_pog.dart';
import 'presentation/rlf_onboarding_pog.dart';
import 'presentation/rlf_splash_pog.dart';

late final SharedPreferences rlfPrefsPog;
const bottomNavigationBar = RLFBottomNavigationBarPOG();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RLFAppCubitPog(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Ubuntu',
          textTheme: TextTheme(
            bodyMedium: TextStyle(
              fontSize: context.isSE ? 14 : 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            displayMedium: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: context.isSE ? 44 : 66,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 0.8,
            ),
          ),
          scaffoldBackgroundColor: const Color.fromRGBO(13, 12, 80, 1),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SbpSplashScreenJus(),
          // '/rlf-nickname-pog': (context) => const RLFNicknameScreenPOG(),
          // '/rlf-onboarding-pog': (context) => const RLFOnboardingPog(),
          // '/rlf-menu-pog': (context) => const RLFMenuPog(bottomNavigationBar: bottomNavigationBar),
          // '/rlf-game-screen-pog': (context) => const RLFGameScreenPOG(),
        },
      ),
    );
  }
}
