// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:tots_test/src/ui/views/auth/view/login_view.dart';
import 'package:tots_test/src/ui/views/home/view/home_view.dart';

import '/src/ui/routes/routes.dart';

abstract class Pages {
  static const String INITIAL = Routes.LOGIN;
  static final Map<String, Widget Function(BuildContext)> routes = {

    Routes.HOME: (_) => const HomeView(),
    Routes.LOGIN: (_) => const LoginView(),

  };
}
