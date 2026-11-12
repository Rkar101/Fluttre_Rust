import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<void> secureWrite(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  static Future<String> secureRead(String key) async {
    return await _storage.read(key: key) ?? "";
  }

  static Future<bool> secureBoolRead(String key) async {
    final flag = await _storage.read(key: key) ?? "";
    return bool.tryParse(flag) ?? false;
  }

  static Future<void> secureDelete() async{
    await _storage.deleteAll();
  }
}
