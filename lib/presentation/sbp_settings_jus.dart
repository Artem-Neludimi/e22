import 'package:e22/core/extensions/rlf_context_extensions_pog.dart';
import 'package:e22/core/navigation/sbp_router_jus.dart';
import 'package:e22/presentation/sbp_widgets_jus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

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
          appBar: SbpAppBarJus(context: context),
          bottomNavigationBar: widget.bottomNavigationBar,
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            child: SingleChildScrollView(
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
                    onTap: () => launchUrl(Uri.parse('https://sportsguru.site/privacy.html')),
                    'Privacy Policy',
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Color.fromRGBO(187, 187, 187, 1),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _item(
                    onTap: () => SbpRoutesJus.termsOfUse.push(context, extra: true),
                    'Terms of Use',
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Color.fromRGBO(187, 187, 187, 1),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _item(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const _SupportDialog(),
                      ).then((value) {
                        if (value == true) {
                          showCupertinoDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                              title: const Text('Message sent'),
                              content: const Text('We will get back to you as soon as possible'),
                              actions: [
                                CupertinoDialogAction(
                                  child: const Text('OK'),
                                  onPressed: () => context.pop(),
                                ),
                              ],
                            ),
                          );
                        }
                      });
                    },
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
                        onTap: () {
                          final rateMyApp = RateMyApp(
                            minDays: 0,
                            minLaunches: 0,
                            remindDays: 0,
                            remindLaunches: 0,
                          )..init();
                          rateMyApp.showRateDialog(context);
                        },
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
                        onTap: () {
                          Share.share('Try this app!');
                        },
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
        ),
      ],
    );
  }

  Expanded _bigItem(Widget child, {Function()? onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
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
      ),
    );
  }

  ListTile _item(String title, Widget trailing, {Function()? onTap}) {
    return ListTile(
      onTap: onTap,
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

class _SupportDialog extends StatefulWidget {
  const _SupportDialog();

  @override
  State<_SupportDialog> createState() => _SupportDialogState();
}

class _SupportDialogState extends State<_SupportDialog> {
  final _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 33),
        Material(
          child: Container(
            width: 300,
            height: 275,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(152, 119, 70, 1),
                  Color.fromRGBO(53, 44, 31, 1),
                ],
              ),
              border: GradientBoxBorder(
                width: 4,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(224, 176, 104, 1),
                    Color.fromRGBO(78, 56, 38, 1),
                  ],
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Support',
                    style: TextStyle(
                      color: Color.fromRGBO(221, 168, 95, 1),
                      fontSize: 33,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                      cursorColor: Colors.white,
                      style: context.sourceSans(),
                      maxLines: 30,
                      decoration: InputDecoration(
                        hintText: 'Describe your problem',
                        hintStyle: context.sourceSans(),
                        filled: true,
                        fillColor: const Color.fromRGBO(30, 30, 30, 0.5),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: 300,
          child: Material(
            child: SbpButtonJus(
              onPressed: () {
                if (_controller.text.isEmpty) return;
                context.pop(true);
              },
              text: 'Send message',
            ),
          ),
        )
      ],
    );
  }
}
