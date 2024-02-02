import 'package:e22/core/extensions/rlf_context_extensions_pog.dart';
import 'package:e22/logic/rlf_app_cubit_pog.dart';
import 'package:e22/presentation/rlf_widgets_pog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e22/core/assets/gen/assets.gen.dart';

class RLFShopPog extends StatefulWidget {
  const RLFShopPog({super.key, required this.bottomNavigationBar});
  final Widget bottomNavigationBar;

  @override
  State<RLFShopPog> createState() => _RLFShopPogState();
}

class _RLFShopPogState extends State<RLFShopPog> {
  int _shopIndex = 0;

  @override
  Widget build(BuildContext context) {
    final textThemes = Theme.of(context).textTheme;
    final appState = context.watch<RLFAppCubitPog>().state;
    return Scaffold(
      bottomNavigationBar: widget.bottomNavigationBar,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('SCORE:', style: textThemes.bodyMedium!.copyWith(fontSize: 24)),
                  const SizedBox(width: 12),
                  Text(appState.score.toString(), style: textThemes.bodyMedium!.copyWith(fontSize: 24)),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: switch (_shopIndex) {
                  0 => const _Avatars(),
                  1 => const _Balls(),
                  _ => const _Boosts(),
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() => _shopIndex = 0);
                    },
                    child: Text(
                      'AVATAR',
                      style: textThemes.bodyMedium!.copyWith(
                        fontSize: 18,
                        color: _shopIndex == 0 ? const Color.fromRGBO(66, 182, 70, 1) : Colors.white,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() => _shopIndex = 1);
                    },
                    child: Text(
                      'BALLS',
                      style: textThemes.bodyMedium!.copyWith(
                        fontSize: 18,
                        color: _shopIndex == 1 ? const Color.fromRGBO(66, 182, 70, 1) : Colors.white,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() => _shopIndex = 2);
                    },
                    child: Text(
                      'BOOST',
                      style: textThemes.bodyMedium!.copyWith(
                        fontSize: 18,
                        color: _shopIndex == 2 ? const Color.fromRGBO(66, 182, 70, 1) : Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Spacer(
                    flex: switch (_shopIndex) {
                      0 => 9,
                      1 => 57,
                      _ => 88,
                    },
                  ),
                  Expanded(
                    flex: switch (_shopIndex) {
                      0 => 20,
                      1 => 19,
                      _ => 20,
                    },
                    child: Container(
                      height: 4,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(66, 182, 70, 1),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  Spacer(
                    flex: switch (_shopIndex) {
                      0 => 80,
                      1 => 56,
                      _ => 10,
                    },
                  ),
                ],
              ),
              Divider(
                color: Colors.white.withOpacity(0.4),
                height: 0,
                thickness: 0.6,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Boosts extends StatelessWidget {
  const _Boosts();

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<RLFAppCubitPog>().state;
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'CHOOSE & BUY',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: 24,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'BOOST',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(),
          ),
          const SizedBox(height: 24),
          ListTile(
            title: Row(
              children: [
                Text(
                  'TRAMPOLINE',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 24),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(66, 182, 70, 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: FittedBox(
                      child: Text(
                        appState.trampolineCount.toString(),
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Assets.images.rlfStarPog.image(),
                const SizedBox(width: 2),
                Text(
                  '500',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white, fontSize: 24),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Text(
                  'Trampoline will jump the ball for a long distance. You can use only one per game',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white.withOpacity(0.5), fontSize: 18),
                ),
                const SizedBox(height: 16),
                RLFAppButtonPOG(
                  onPressed: () {
                    try {
                      context.read<RLFAppCubitPog>().tryBuyTrampoline();
                      context.showSnackBar('Trampoline bought');
                    } catch (e) {
                      context.showSnackBar('Not enough score');
                    }
                  },
                  child: Text(
                    'BUY',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.white.withOpacity(0.3),
            height: 24,
          ),
          ListTile(
            title: Row(
              children: [
                Text(
                  'X2 POINTS',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 24),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(66, 182, 70, 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: FittedBox(
                      child: Text(
                        appState.scoreMultiplierCount.toString(),
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Assets.images.rlfStarPog.image(),
                const SizedBox(width: 2),
                Text(
                  '500',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white, fontSize: 24),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Text(
                  'X2 points will double your score while you in the game. You can use only ont per game',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white.withOpacity(0.5), fontSize: 18),
                ),
                const SizedBox(height: 16),
                RLFAppButtonPOG(
                  onPressed: () {
                    try {
                      context.read<RLFAppCubitPog>().tryBuyScoreMultiplier();
                      context.showSnackBar('Score multiplier bought');
                    } catch (e) {
                      context.showSnackBar('Not enough score');
                    }
                  },
                  child: Text(
                    'BUY',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Balls extends StatefulWidget {
  const _Balls();

  @override
  State<_Balls> createState() => _BallsState();
}

class _BallsState extends State<_Balls> {
  int _index = 0;
  final _ballImages = [
    Assets.images.rlfBallPog.path,
    Assets.images.rlfBall2Pog.path,
    Assets.images.rlfBall3Pog.path,
  ];
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<RLFAppCubitPog>().state;
    final isBallBought = appState.isImageBought(_ballImages[_index]);
    final isBallEquipped = appState.isBallEquipped(_ballImages[_index]);
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          Text(
            'CHOOSE & BUY',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: 24,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'BALLS',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.5,
            child: Align(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: constraints.maxWidth * 0.5,
                  enlargeCenterPage: true,
                  viewportFraction: 0.5,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() => _index = index);
                  },
                ),
                items: _ballImages
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(e, fit: BoxFit.fill),
                        ))
                    .toList(),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _index == 0 ? const Color.fromRGBO(66, 182, 70, 1) : Colors.white.withOpacity(0.4),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _index == 1 ? const Color.fromRGBO(66, 182, 70, 1) : Colors.white.withOpacity(0.4),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _index == 2 ? const Color.fromRGBO(66, 182, 70, 1) : Colors.white.withOpacity(0.4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!isBallBought) ...[
                  Assets.images.rlfStarPog.image(),
                  const SizedBox(width: 2),
                  Text(_index == 1 ? '1000' : '2000'),
                ],
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: RLFAppButtonPOG(
                  onPressed: () {
                    if (!isBallBought) {
                      final price = _index == 1 ? 1000 : 2000;
                      final image = _ballImages[_index];
                      try {
                        context.read<RLFAppCubitPog>().tryBuyImage(image, price);
                        context.showSnackBar('Ball bought');
                        return;
                      } catch (e) {
                        context.showSnackBar('Not enough score');
                      }
                    } else {
                      try {
                        context.read<RLFAppCubitPog>().tryEquipBall(_ballImages[_index]);
                        return;
                      } catch (e) {
                        context.showSnackBar('Ball already equipped');
                      }
                    }
                  },
                  child: Text(
                    !isBallBought
                        ? 'BUY'
                        : isBallEquipped
                            ? 'EQUIPPED'
                            : 'EQUIP',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Avatars extends StatefulWidget {
  const _Avatars();

  @override
  State<_Avatars> createState() => _AvatarsState();
}

class _AvatarsState extends State<_Avatars> {
  int _index = 0;
  final _avatarImages = [
    Assets.images.rlfFootballer1Pog.path,
    Assets.images.rlfFootballer2Pog.path,
    Assets.images.rlfFootballer3Pog.path,
  ];
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<RLFAppCubitPog>().state;
    final isAvatarBought = appState.isImageBought(_avatarImages[_index]);
    final isAvatarEquipped = appState.isAvatarEquipped(_avatarImages[_index]);
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          Text(
            'CHOOSE & BUY',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: 24,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'AVATAR',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.5,
            child: Align(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: constraints.maxWidth * 0.5,
                  enlargeCenterPage: true,
                  viewportFraction: 0.5,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() => _index = index);
                  },
                ),
                items: _avatarImages
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(e, fit: BoxFit.fill),
                        ))
                    .toList(),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _index == 0 ? const Color.fromRGBO(66, 182, 70, 1) : Colors.white.withOpacity(0.4),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _index == 1 ? const Color.fromRGBO(66, 182, 70, 1) : Colors.white.withOpacity(0.4),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _index == 2 ? const Color.fromRGBO(66, 182, 70, 1) : Colors.white.withOpacity(0.4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!isAvatarBought) ...[
                  Assets.images.rlfStarPog.image(),
                  const SizedBox(width: 2),
                  Text(_index == 1 ? '1000' : '2000'),
                ],
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: RLFAppButtonPOG(
                  onPressed: () {
                    if (!isAvatarBought) {
                      final price = _index == 1 ? 1000 : 2000;
                      final image = _avatarImages[_index];
                      try {
                        context.read<RLFAppCubitPog>().tryBuyImage(image, price);
                        context.showSnackBar('Avatar bought');
                        return;
                      } catch (e) {
                        context.showSnackBar('Not enough score');
                      }
                    } else {
                      try {
                        context.read<RLFAppCubitPog>().tryEquipAvatar(_avatarImages[_index]);
                        return;
                      } catch (e) {
                        context.showSnackBar('Avatar already equipped');
                      }
                    }
                  },
                  child: Text(
                    !isAvatarBought
                        ? 'BUY'
                        : isAvatarEquipped
                            ? 'EQUIPPED'
                            : 'EQUIP',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
