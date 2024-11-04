import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tots_test/src/ui/common/util/app_color.dart';
import 'package:tots_test/src/ui/common/util/assets.dart';
import 'package:tots_test/src/ui/common/util/responsive.dart';
import 'package:tots_test/src/ui/common/widgets/custom_button.dart';
import 'package:tots_test/src/ui/views/home/contact_controller.dart';
import 'package:tots_test/src/ui/views/home/widgets/actions_bar.dart';
import 'package:tots_test/src/ui/views/home/widgets/clients_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return ChangeNotifierProvider(
      create: (context) => ClientController(),
      builder: (context, child) => Scaffold(
        body: GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          behavior: HitTestBehavior.translucent,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              ..._background(responsive),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.wp(10),
                  ).copyWith(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: Image.asset(AppAssets.logo, width: 100)),
                      SizedBox(height: responsive.hp(4)),
                      const Text(
                        'CLIENTS',
                        style: TextStyle(
                            letterSpacing: 1,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: AppColors.gray),
                      ),
                      SizedBox(height: responsive.hp(3)),
                      const ActionsBar(),
                      SizedBox(height: responsive.hp(2)),
                      const ClientsList(),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: responsive.hp(4)),
                        child: CustomButton(
                          text: 'LOAD MORE',
                          onTap: () {},
                        ),
                      )
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

  _background(Responsive responsive) => [
        const SizedBox.expand(),
        Positioned(
        
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 40.0),
            child: SvgPicture.asset(
              AppAssets.backgroundHome1,
            ),
          ),
        ),
         Positioned(
          right: 0,
        
          top: responsive.hp(25),
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 40.0),
            child: SvgPicture.asset(
              AppAssets.backgroundHome2,
            ),
          ),
        ),
        Positioned(
          bottom: 22,
          left: 0,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 40.0),
            child: SvgPicture.asset(
              AppAssets.backgroundHome3,
            ),
          ),
        ),

         Positioned(
          bottom: 0,
          right: 0,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 40.0),
            child: SvgPicture.asset(
              AppAssets.backgroundHome4,
            ),
          ),
        ),
      
       /* Positioned(
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
        ),*/
      ];
}
