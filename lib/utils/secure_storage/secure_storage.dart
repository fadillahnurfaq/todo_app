import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();

  static const _keyToken = 'token';

  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  static Future setToken(String userToken) async => await _storage.write(
        key: _keyToken,
        value: userToken,
        aOptions: _getAndroidOptions(),
      );

  static Future<String?> getToken() async => await _storage.read(
        key: _keyToken,
        aOptions: _getAndroidOptions(),
      );
}
