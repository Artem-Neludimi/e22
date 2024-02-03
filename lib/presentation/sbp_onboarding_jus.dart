import 'package:e22/core/assets/gen/assets.gen.dart';
import 'package:e22/core/extensions/rlf_context_extensions_pog.dart';
import 'package:e22/core/navigation/sbp_router_jus.dart';
import 'package:e22/presentation/sbp_widgets_jus.dart';
import 'package:flutter/material.dart';

class SbpOnboardingJus extends StatefulWidget {
  const SbpOnboardingJus({super.key});

  @override
  State<SbpOnboardingJus> createState() => _SbpOnboardingJusState();
}

class _SbpOnboardingJusState extends State<SbpOnboardingJus> {
  final _controller = PageController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _controller,
            children: [
              _SbpPageJus(
                title: 'WELCOME TO THE GAME',
                description: 'Have fun and enjoy our game. Your journey begins!',
                image: Assets.images.sbpOnboardingBg1Jus.path,
              ),
              _SbpPageJus(
                title: 'GAME MECHANICS',
                description: 'Use swipe in any direction  to change cube position',
                image: Assets.images.sbpOnboardingBg2Jus.path,
              ),
              _SbpPageJus(
                title: 'MAIN GOAL — FILL THE CONTOUR',
                description: 'Your goal is to place cube in white contour',
                image: Assets.images.sbpOnboardingBg3Jus.path,
              ),
            ],
          ),
          Positioned(
            bottom: 32,
            right: 16,
            left: 16,
            child: Row(
              children: [
                _SbpPointJus(_controller.hasClients && _controller.page == 0),
                const SizedBox(width: 8),
                _SbpPointJus(_controller.hasClients && _controller.page == 1),
                const SizedBox(width: 8),
                _SbpPointJus(_controller.hasClients && _controller.page == 2),
                const SizedBox(width: 80),
                Expanded(
                  child: SbpButtonJus(
                    onPressed: () async {
                      if (_controller.page == 2) {
                        SbpRoutesJus.menu.go(context);
                        return;
                      }
                      await _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                      setState(() {});
                    },
                    text: 'Continue',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _SbpPageJus extends StatelessWidget {
  const _SbpPageJus({
    required this.title,
    required this.description,
    required this.image,
  });
  final String title;
  final String description;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          image,
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: 130,
          left: 16,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                textAlign: TextAlign.left,
                style: context.sourceSans(size: 44, weight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                'Have fun and enjoy our game. Your journey begins!',
                textAlign: TextAlign.left,
                style: context.sourceSans(size: 22, color: Colors.grey),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _SbpPointJus extends StatelessWidget {
  const _SbpPointJus(this.isActive);
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            if (isActive) ...[
              const Color.fromRGBO(224, 176, 104, 1),
              const Color.fromRGBO(78, 56, 38, 1),
            ] else ...[
              const Color.fromRGBO(78, 56, 38, 1),
              const Color.fromRGBO(78, 56, 38, 1),
            ],
          ],
        ),
      ),
    );
  }
}
