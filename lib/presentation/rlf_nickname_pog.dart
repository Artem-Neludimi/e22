import 'package:e22/core/extensions/rlf_context_extensions_pog.dart';
import 'package:e22/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e22/core/assets/gen/assets.gen.dart';

import '../logic/rlf_app_cubit_pog.dart';
import 'sbp_widgets_jus.dart';

class RLFNicknameScreenPOG extends StatefulWidget {
  const RLFNicknameScreenPOG({super.key});

  @override
  State<RLFNicknameScreenPOG> createState() => _RLFNicknameScreenPOGState();
}

class _RLFNicknameScreenPOGState extends State<RLFNicknameScreenPOG> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
          // image: DecorationImage(
          //   image: Assets.images.rlfNicknameBgPog.provider(),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'ENTER\nYOUR\nNAME',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  height: context.isSE ? 55 : 70,
                  child: TextField(
                    controller: _controller,
                    onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: const Color.fromRGBO(148, 150, 193, 1),
                        ),
                    decoration: InputDecoration(
                      hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: const Color.fromRGBO(148, 150, 193, 1),
                          ),
                      hintText: 'player name',
                      filled: true,
                      fillColor: const Color.fromRGBO(42, 46, 131, 1),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(44),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(44),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(44),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: context.isSE ? 55 : 70,
                  width: double.maxFinite,
                  child: ListenableBuilder(
                    listenable: _controller,
                    builder: (context, _) => RLFAppButtonPOG(
                      onPressed: _controller.text.isEmpty
                          ? null
                          : () {
                              context.read<RLFAppCubitPog>().setName(_controller.text);
                              if (rlfPrefsPog.getBool('isFirstTime') ?? true) {
                                Navigator.of(context).pushReplacementNamed('/rlf-onboarding-pog');
                              } else {
                                Navigator.of(context).pushReplacementNamed('/rlf-menu-pog');
                              }
                            },
                      child: Text(
                        'CONTINUE',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: _controller.text.isEmpty ? const Color.fromRGBO(148, 150, 193, 1) : Colors.white,
                            ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
