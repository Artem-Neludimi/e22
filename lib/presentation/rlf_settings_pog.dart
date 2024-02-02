import 'package:e22/extensions/rlf_context_extensions_pog.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:url_launcher/url_launcher.dart';

import '../logic/rlf_app_cubit_pog.dart';

class RLFSettingsPog extends StatefulWidget {
  const RLFSettingsPog({super.key, required this.bottomNavigationBar});
  final Widget bottomNavigationBar;

  @override
  State<RLFSettingsPog> createState() => _RLFSettingsPogState();
}

class _RLFSettingsPogState extends State<RLFSettingsPog> {
  final _controller = TextEditingController();
  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appCubit = context.watch<RLFAppCubitPog>();
    return GestureDetector(
      onTap: () {
        _controller.clear();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        bottomNavigationBar: widget.bottomNavigationBar,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SafeArea(
          child: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text('SETTINGS'),
                    const SizedBox(height: 24),
                    Image.asset(appCubit.state.avatarImage),
                    const SizedBox(height: 24),
                    _NicknameTextField(controller: _controller),
                    const SizedBox(height: 16),
                    _rlfSettingSwitchElementPog(
                      () {
                        appCubit.setSound(!appCubit.state.sound);
                      },
                      'Sound Effects',
                      appCubit.state.sound,
                    ),
                    _settingDivider(),
                    _rlfSettingSwitchElementPog(
                      () async {
                        if (FlameAudio.bgm.isPlaying) {
                          await FlameAudio.bgm.stop();
                        } else {
                          await FlameAudio.bgm.play('rlf_music_pog.mp3');
                        }
                        setState(() {});
                      },
                      'Music',
                      FlameAudio.bgm.isPlaying,
                    ),
                    _settingDivider(),
                    _rlfSettingElementPog(
                      () {
                        launchUrl(Uri.parse('https://sportsguru.site/privacy.html'));
                      },
                      'Privacy Policy',
                    ),
                    _settingDivider(),
                    _rlfSettingElementPog(
                      () {
                        launchUrl(Uri.parse('https://sportsguru.site/terms.html'));
                      },
                      'Terms of Use',
                    ),
                    _settingDivider(),
                    _rlfSettingElementPog(
                      () {
                        final rateMyApp = RateMyApp(
                          minDays: 0,
                          minLaunches: 0,
                          remindDays: 0,
                          remindLaunches: 0,
                        )..init();
                        rateMyApp.showRateDialog(context);
                      },
                      'Rate Us',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: ListenableBuilder(
          listenable: _controller,
          builder: (context, _) {
            if (_controller.text.isEmpty) return const SizedBox();
            return FloatingActionButton.extended(
              backgroundColor: const Color.fromRGBO(42, 46, 131, 1),
              onPressed: () {
                appCubit.setName(_controller.text);
                context.showSnackBar('Name changed to ${_controller.text}');
                _controller.clear();
              },
              label: Text(
                'CHANGE NAME',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          },
        ),
      ),
    );
  }

  Divider _settingDivider() {
    return const Divider(
      color: Color.fromRGBO(148, 150, 193, 0.5),
      thickness: 0.8,
      endIndent: 16,
      indent: 16,
    );
  }

  Widget _rlfSettingSwitchElementPog(VoidCallback onTap, String text, bool value) {
    return ListTile(
      onTap: onTap,
      title: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
      ),
      trailing: CupertinoSwitch(
        value: value,
        onChanged: (value) {
          onTap.call();
        },
      ),
    );
  }

  Widget _rlfSettingElementPog(VoidCallback onTap, String text) {
    return ListTile(
      onTap: onTap,
      title: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Color.fromRGBO(148, 150, 193, 1),
      ),
    );
  }
}

class _NicknameTextField extends StatelessWidget {
  const _NicknameTextField({
    required TextEditingController controller,
  }) : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    final name = context.watch<RLFAppCubitPog>().state.name;
    return SizedBox(
      height: context.isSE ? 55 : 70,
      child: TextField(
        controller: _controller,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: const Color.fromRGBO(148, 150, 193, 1),
            ),
        decoration: InputDecoration(
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: const Color.fromRGBO(148, 150, 193, 1),
              ),
          hintText: name,
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
    );
  }
}
