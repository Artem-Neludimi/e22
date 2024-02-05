import 'package:e22/core/extensions/sbp_context_extensions_jus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

import '../core/assets/gen/assets.gen.dart';
import 'sbp_widgets_jus.dart';

class SbpShopJus extends StatefulWidget {
  const SbpShopJus({super.key, required this.bottomNavigationBar});
  final Widget bottomNavigationBar;

  @override
  State<SbpShopJus> createState() => _SbpShopJusState();
}

class _SbpShopJusState extends State<SbpShopJus> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Assets.images.sbpShopBgJus.image(
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Scaffold(
          appBar: SbpAppBarJus(context: context),
          bottomNavigationBar: widget.bottomNavigationBar,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: ListView(
              children: [
                _item(
                  Center(child: Assets.images.sbpCubeJus.image(height: 75, width: 75)),
                  'Simple Cube',
                  'Reskin for cube',
                  'Using',
                ),
                _item(
                  Center(child: Assets.images.sbpCube2Jus.image(height: 75, width: 75)),
                  'Dark Triangle',
                  'Reskin for cube',
                  '400',
                ),
                _item(
                  Center(child: Assets.images.sbpCube3Jus.image(height: 75, width: 75)),
                  'King of Kings',
                  'Reskin for cube',
                  '800',
                ),
                _item(
                  Assets.images.bg.image(
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  'Map Background',
                  'Background for map',
                  '1600',
                ),
                _item(
                  Assets.images.bg2.image(
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  'Map Background',
                  'Background for map',
                  '2000',
                ),
                _item(
                  Assets.images.bg3.image(
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  'Map Background',
                  'Background for map',
                  '2300',
                ),
                _item(
                  Assets.images.sbpCounterJus.image(
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                  'New Contour',
                  'Reskin for contour',
                  '2600',
                ),
                _item(
                  Assets.images.x2.image(
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                  'Daily Bonus x2',
                  'Reward for daily bonus',
                  '3000',
                ),
                _item(
                  Assets.images.x3.image(
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                  'Daily Bonus x3',
                  'Reward for daily bonus',
                  '4000',
                ),
                _item(
                  Assets.images.wx2.image(
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                  'Reward x2',
                  'Reward for win',
                  '3000',
                ),
                _item(
                  Assets.images.wx3.image(
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                  'Reward x3',
                  'Reward for win',
                  '4000',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _item(
    Widget image,
    String title,
    String subtitle,
    String money, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap ??
          () {
            showDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: const Text('Not enough credits'),
                  content: const Text('Earn more credits by playing the game!'),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text('Ok'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          },
      child: Container(
        height: 175,
        margin: const EdgeInsets.only(bottom: 8),
        decoration: const BoxDecoration(
          color: Colors.black,
          border: GradientBoxBorder(
            width: 2,
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
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(30, 30, 30, 1),
                    border: GradientBoxBorder(
                      width: 2,
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
                  child: image,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          title,
                          style: context.sourceCode(size: 24),
                        ),
                      ),
                      Text(
                        subtitle,
                        style: context.sourceCode(size: 16, color: const Color(0xFFE0B068)),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 55,
                        child: SbpMoneyBoardJus(money: money),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
