import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecSto {
  final _storage = FlutterSecureStorage();
  Future writeSecureData(String key, String value) async {
    var writeData = await _storage.write(key: key, value: value);
    return writeData;
  }

  Future<String?> readData(String key) async {
    String? readData = await _storage.read(key: key);
    return readData;
  }

  Future deleteData() async {
    await _storage.deleteAll();
  }
}
