import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tots_test/src/ui/common/util/assets.dart';
import 'package:tots_test/src/ui/views/auth/widgets/login_formulary.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        behavior:  HitTestBehavior.translucent,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            ..._background(),
            const LoginFormulary()
          ],
        ),
      ),
    );
  }

  _background() => [
        const SizedBox.expand(),
        Positioned(
          right: -10,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 60.0),
            child: SvgPicture.asset(
              AppAssets.backgroundLogo1,
            ),
          ),
        ),
        Positioned(
          top: 350,
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

