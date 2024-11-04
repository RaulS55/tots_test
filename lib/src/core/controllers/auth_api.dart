import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:tots_test/src/services/http_format.dart';

class AuthApi {
  static final AuthApi _instance = AuthApi._internal();

  factory AuthApi() => _instance;

  AuthApi._internal();

  
  
  Future<Either<String,String>> login({
    required String email,
    required String password,
  }) async {
    final response = await httpFunction(
      "POST",
      '/6-tots-test/oauth/token',
      jsonEncode(<String, dynamic>{
        "email": email,
        "password": password,
      }),
      {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      log: true,
    );
    if(response['access_token'] == null ) return Left(response['message']);
    return Right(response['access_token']) ;
  }
  
}