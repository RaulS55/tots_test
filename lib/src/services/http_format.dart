import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:tots_test/src/core/constants/data.dart';
import 'package:tots_test/src/services/internet_service.dart';

late BuildContext context;

Future<Map<dynamic, dynamic>> httpFunction(
    String type, String path, Object? body, Map<String, String>? headers,
    {bool log = false,
    BuildContext? context,
    bool successMessage = false,
    bool chatbotApi = false,
    Map<String, String>? params}) async {
  try {
    //Verifica conexion a internet
    if (await InternetServices.instance.connected()) {
      final url = Uri.https(
        Constants.urlRest,
        path,
        params,
      );
      //Protocolo de petición
      late Map data;
      switch (type) {
        case "POST":
          var response = await http.post(url, body: body, headers: headers);
          var val = jsonEncode({
            "status_code": response.statusCode,
            "body": utf8.decode(response.bodyBytes),
          });

          final value = response.body.isEmpty
              ? jsonEncode({'statusCode': response.statusCode})
              : response.body;

          data = jsonDecode(chatbotApi ? val : value);
          break;
        case "PUT":
          var response = await http.put(url, body: body, headers: headers);

          try {
            data = jsonDecode(response.body);
          } catch (_) {
            data = {'statusCode': response.statusCode};
          }
          break;
        case "GET":
          var response = await http.get(url, headers: headers);
          try {
            data = jsonDecode(response.body);
          } catch (_) {
            data = {'statusCode': response.statusCode};
          }

          break;
        case "DELETE":
          var response = await http.delete(url, body: body, headers: headers);
          final value = response.body.isEmpty
              ? jsonEncode({'statusCode': response.statusCode})
              : response.body;
          data = jsonDecode(value);
          break;
      }

      if (log) dev.log('$type $path: ${jsonEncode(data)}');

      //#Configurable
      switch (data["statusCode"]) {
        case 200:
        case 201:
        case 204:
        case 400:
        case 401:
        case 403:
        case 404:
        case 405:
        case 409:       
        case 502:
          return data;
        default:
          return data;
      }
    } else {
       return {"message":"connection error."};
    }
  } catch (e) {
    if (log) dev.log('Error: $e');

    return {};
  }
}

/// Creates a multipart request.
Future<Map<dynamic, dynamic>?> httpMultipartFunction(
  String type,
  String path,
  Map<String, String> body,
  List<http.MultipartFile> files,
  Map<String, String>? headers, {
  Map<String, String>? params,
  bool log = false,
}) async {
  try {
    final isConnected = await InternetServices.instance.connected();
    if (!isConnected) return null;

    final request = http.MultipartRequest(
      type,
      Uri.https(Constants.urlRest, path, params),
    );
    request.headers.addAll(headers ?? {});
    request.fields.addAll(body);
    request.files.addAll(files);
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    final data = jsonDecode(response.body) as Map<String, dynamic>;

    if (log) dev.log(data.toString());

    switch (data["statusCode"]) {
      case 200:
      case 201:
        return data;
      case 400:
        return data;
      case 401:
        return data;
      case 403:
        return data;
      case 404:
        return data;
      case 405:
        dev.log(data.toString());
        return null;
      case 500:
        dev.log(data.toString());
        return null;
      default:
        dev.log(data.toString());
        return null;
    }
  } catch (e) {
    dev.log('ERROR $e');

    return null;
  }
}

/// Creates a multipart request with upload progress.
Future<Map<dynamic, dynamic>?> httpMultipartFunctionProgress(
  String type,
  String path,
  Map<String, String> body,
  List<http.MultipartFile> files,
  Map<String, String>? headers, {
  Map<String, String>? params,
  bool log = false,
  Function(double progress)?
      onUploadProgress, // Callback para el progreso de la subida
}) async {
  try {
    final isConnected = await InternetServices.instance.connected();
    if (!isConnected) return null;

    final request = http.MultipartRequest(
      type,
      Uri.https(Constants.urlRest, path, params),
    );

    request.headers.addAll(headers ?? {});
    request.fields.addAll(body);
    request.files.addAll(files);

    // Obtener la longitud total de los archivos para calcular el progreso.
    final totalBytes = request.contentLength;

    // Convertir el request a un ByteStream.
    final byteStream = http.ByteStream(request.finalize());

    int bytesSent = 0;

    // Escuchar los datos enviados para calcular el progreso.
    final Stream<List<int>> stream = byteStream.transform(
      StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          bytesSent += data.length;
          double progress = bytesSent / totalBytes;

          if (onUploadProgress != null) {
            onUploadProgress(progress); // Llamar al callback con el progreso.
          }
          sink.add(data); // Añadir los datos al stream.
        },
      ),
    );

    final streamedRequest =
        http.StreamedRequest(type, Uri.https(Constants.urlRest, path, params))
          ..headers.addAll(request.headers)
          ..contentLength = totalBytes;

    streamedRequest.sink.addStream(stream).whenComplete(() async {
      await streamedRequest.sink.close();
    });

    final streamedResponse = await streamedRequest.send();
    final response = await http.Response.fromStream(streamedResponse);

    Map<String, dynamic> data = {};

    try {
      data = jsonDecode(response.body);
    } catch (e) {
      data = {'statusCode': response.statusCode};

      dev.log('Error: $e');
    }

    if (log) dev.log('$path: ${jsonEncode(data)}');

    switch (data["statusCode"]) {
      case 200:
      case 201:
        return data;
      case 400:
        return data;
      case 401:
        return data;
      case 403:
        return data;
      case 404:
        return data;
      case 405:
        dev.log(data.toString());
        return null;
      case 500:
        dev.log(data.toString());
        return null;
      default:
        dev.log(data.toString());
        return null;
    }
  } catch (e) {
    dev.log('ERROR $e');
    return null;
  }
}
