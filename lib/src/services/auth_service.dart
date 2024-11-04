import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  // Crea una instancia del almacenamiento seguro
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Guarda el access token
  Future<void> saveAccessToken(String token) async {
    await _secureStorage.write(key: 'access_token', value: token);
  }

  // Lee el access token
  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: 'access_token');
  }

  // Borra el access token (por ejemplo, al cerrar sesión)
  Future<void> deleteAccessToken() async {
    await _secureStorage.delete(key: 'access_token');
  }
}