import 'package:flutter/material.dart';
import 'package:tots_test/src/core/controllers/auth_api.dart';
import 'package:tots_test/src/services/auth_service.dart';

class AuthController extends ChangeNotifier{
  bool isLoading = false;

  Future<String?> login({ required String email,
    required String password,}) async{
    isLoading = true;
    notifyListeners();

    final response = await AuthApi().login(email: email, password: password);

    isLoading = false;
    notifyListeners();

    if(response.isLeft) return response.left;
    AuthService().saveAccessToken(response.right);
    return null;
  }

}