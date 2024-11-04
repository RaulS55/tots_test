import 'package:flutter/material.dart';
import 'package:tots_test/src/ui/common/util/app_color.dart';
import 'package:tots_test/src/ui/routes/pages.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tots test',
      initialRoute: Pages.INITIAL,
        routes: Pages.routes,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      popupMenuTheme: const PopupMenuThemeData(
      color: AppColors.black, 
      textStyle: TextStyle(color:  AppColors.white),
    ),
        useMaterial3: true,
      ),
   
    );
  }
}