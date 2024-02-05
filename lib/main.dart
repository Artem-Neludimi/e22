import 'package:e22/core/navigation/sbp_router_jus.dart';
import 'package:e22/logic/sbp_app_cubit_jus.dart';
import 'package:e22/logic/sbp_bonus_cubit_jus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final SharedPreferences sbpPrefsJus;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SbpAppCubitJus(),
        ),
        BlocProvider(
          create: (context) => SbpBonusCubitJus(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.transparent,
        ),
        routerConfig: sbpRouterJus,
      ),
    );
  }
}
