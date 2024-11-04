import 'dart:developer';
import 'package:either_dart/either.dart';
import 'package:tots_test/src/services/http_format.dart';
import 'package:tots_test/src/ui/views/home/models/client.dart';

class ClientApi {
  static final ClientApi _instance = ClientApi._internal();

  factory ClientApi() => _instance;

  ClientApi._internal();

  Future<Either<String, Client>> add({
    required String token,
    required Client client,
  }) async {
    final response = await httpFunction(
      "POST",
      '/6-tots-test/clients',
      client.toJson(),
      {
        //'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      log: true,
    );
    if (response['id'] == null) return const Left('error');
    final id = int.parse(response['id']);
    return Right(
      client.copyWith(id: id),
    );
  }

  Future edit({
    required String token,
    required Client client,
  }) async {
    await httpFunction(
      "PUT",
      '/6-tots-test/clients/${client.id}',
      client.toJson(),
      {
        //'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      log: true,
    );
  }

  Future<List<Client>> get({
    required String token,
  }) async {
    final response = await httpFunction(
      "GET",
      '/6-tots-test/clients',
      null,
      // params: {
      //   'page': '2',
      //   'limit': '5',
      // },
      {
        //'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      //log: true,
    );
    if (response['data'] == null) return [];
    try {
      return (response['data'] as List).map((json) {
        log(json.toString());
        return Client.fromJson(json);
      }).toList();
    } catch (e) {
      log('get error: $e');
      return [];
    }
  }

  Future<Either<String, Client>> fetch({
    required String token,
    required String id,
  }) async {
    final response = await httpFunction(
      "GET",
      '/6-tots-test/clients/$id',
      null,
      {
        //'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      //log: true,
    );
    log(response.toString());
    if (response['message'] != null) return Left(response['message']);
    return Right(Client.fromJson(response as Map<String,dynamic>));
  }

  Future delete({
    required String token,
    required String id,
  }) async {
    await httpFunction(
      "DELETE",
      '/6-tots-test/clients/$id',
      null,
      {
        'Authorization': 'Bearer $token',
      },
      log: true,
    );
  }
}
