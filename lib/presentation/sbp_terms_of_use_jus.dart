import 'package:e22/core/extensions/rlf_context_extensions_pog.dart';
import 'package:flutter/material.dart';

import 'package:e22/core/assets/gen/assets.gen.dart';

import 'sbp_widgets_jus.dart';

class SbpTermsOfUseScreenJus extends StatelessWidget {
  const SbpTermsOfUseScreenJus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.sbpOnboardingBg1Jus.provider(),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SbpBoardJus(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Terms of Use',
                              style: context.inter(size: 36, weight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              '''“User Content” means any and all information and content that a user submits to the Site. You are exclusively responsible for your User Content. You bear all risks associated with use of your User Content.  You hereby certify that your User Content does not violate our Acceptable Use Policy.  You may not represent or imply to others that your User Content is in any way provided, sponsored or endorsed by Company.
                        
Because you alone are responsible for your User Content, you may expose yourself to liability. Company is not obliged to backup any User Content that you post; also, your User Content may be deleted at any time without prior notice to you. You are solely responsible for making your own backup copies of your User Content if you desire.
                        
You hereby grant to Company an irreversible, nonexclusive, royalty-free and fully paid, worldwide license to reproduce, distribute, publicly display and perform, prepare derivative works of, incorporate into other works, and otherwise use and exploit your User Content, and to grant sublicenses of the foregoing rights, solely for the purposes of including your User Content in the Site.  You hereby irreversibly waive any claims and assertions of moral rights or attribution with respect to your User Content.''',
                              style: context.inter(size: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                SbpButtonJus(
                  // onPressed: () => SbpRoutesJus.nickname.go(context),
                  child: Text(
                    'I agree',
                    style: context.inter(size: 33, color: const Color.fromRGBO(221, 168, 95, 1)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
