import 'package:e22/core/extensions/rlf_context_extensions_pog.dart';
import 'package:e22/presentation/sbp_widgets_jus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

import '../core/assets/gen/assets.gen.dart';

class SbpSettingsJus extends StatefulWidget {
  const SbpSettingsJus({super.key, required this.bottomNavigationBar});
  final Widget bottomNavigationBar;

  @override
  State<SbpSettingsJus> createState() => _SbpSettingsJusState();
}

class _SbpSettingsJusState extends State<SbpSettingsJus> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Assets.images.sbpGameBgJus.image(
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Scaffold(
          appBar: SbpAppBarJus(),
          bottomNavigationBar: widget.bottomNavigationBar,
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _item(
                  'Notification',
                  CupertinoSwitch(
                    activeColor: const Color.fromRGBO(240, 219, 106, 1),
                    trackColor: const Color.fromRGBO(194, 148, 75, 1),
                    value: true,
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(height: 12),
                _item(
                  'Privacy Policy',
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Color.fromRGBO(187, 187, 187, 1),
                  ),
                ),
                const SizedBox(height: 12),
                _item(
                  'Terms of Use',
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Color.fromRGBO(187, 187, 187, 1),
                  ),
                ),
                const SizedBox(height: 12),
                _item(
                  'Support',
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Color.fromRGBO(187, 187, 187, 1),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _bigItem(
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Align(
                                alignment: const Alignment(0.0, -0.2),
                                child: SizedBox(
                                  height: 55,
                                  child: Assets.images.sbpRateJus.image(fit: BoxFit.fitHeight),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 12,
                              left: 0,
                              right: 0,
                              child: Text(
                                'Rate us',
                                textAlign: TextAlign.center,
                                style: context.sourceCode(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _bigItem(
                      Stack(
                        children: [
                          Positioned.fill(
                            child: Align(
                              alignment: const Alignment(0.0, -0.2),
                              child: SizedBox(
                                height: 55,
                                child: Assets.images.sbpShareJus.image(fit: BoxFit.fitHeight),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 12,
                            left: 0,
                            right: 0,
                            child: Text(
                              'Share',
                              textAlign: TextAlign.center,
                              style: context.sourceCode(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Expanded _bigItem(Widget child) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1.2,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.black,
            border: GradientBoxBorder(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(194, 148, 75, 1),
                  Color.fromRGBO(80, 57, 39, 1),
                ],
              ),
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  ListTile _item(String title, Widget trailing) {
    return ListTile(
      tileColor: Colors.black,
      shape: const GradientBoxBorder(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(194, 148, 75, 1),
            Color.fromRGBO(80, 57, 39, 1),
          ],
        ),
      ),
      title: Text(
        title,
        style: context.sourceCode(),
      ),
      trailing: trailing,
    );
  }
}
