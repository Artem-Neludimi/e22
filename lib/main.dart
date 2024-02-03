import 'package:e22/core/extensions/rlf_context_extensions_pog.dart';
import 'package:e22/core/navigation/sbp_router_jus.dart';
import 'package:e22/logic/rlf_app_cubit_pog.dart';
import 'package:e22/presentation/rlf_widgets_pog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      child: MaterialApp.router(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(13, 12, 80, 1),
        ),
        routerConfig: sbpRouterJus,
      ),
    );
  }
}
