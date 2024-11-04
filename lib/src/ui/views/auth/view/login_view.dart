import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tots_test/src/ui/common/util/assets.dart';
import 'package:tots_test/src/ui/common/util/responsive.dart';
import 'package:tots_test/src/ui/views/auth/widgets/login_formulary.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Scaffold(
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        behavior:  HitTestBehavior.translucent,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            ..._background(responsive),
            const LoginFormulary()
          ],
        ),
      ),
    );
  }

  _background(Responsive responsive) => [
        const SizedBox.expand(),
        Positioned(
          right: -10,
          top: 60,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 60.0, sigmaY: 40.0),
            child: SvgPicture.asset(
              AppAssets.backgroundLogo1
            ),
          ),
        ),
        Positioned(
          top: responsive.hp(45),
          left: 0,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
            child: SvgPicture.asset(
              AppAssets.backgroundLogo2,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 60.0),
            child: SvgPicture.asset(
              AppAssets.backgroundLogo3,
            ),
          ),
        ),
      ];
}

