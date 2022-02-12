import 'dart:convert';

import 'package:seyahat_asistani/core/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  static final CacheManager _instance = CacheManager._init();

  SharedPreferences? _preferences;
  static CacheManager get instance => _instance;

  CacheManager._init() {
    SharedPreferences.getInstance().then((value) {
      _preferences = value;
    });
  }
  static Future prefrencesInit() async {
    instance._preferences ??= await SharedPreferences.getInstance();
  }

  Future<void> clearAll() async {
    await _preferences!.clear();
  }

  Future<void> setStringValue(String key, String value) async {
    await _preferences!.setString(key.toString(), value);
  }

  Future<void> setBoolValue(String key, bool value) async {
    await _preferences!.setBool(key.toString(), value);
  }

  String getStringValue(String key) =>
      _preferences?.getString(key.toString()) ?? '';

  bool getBoolValue(String key) =>
      _preferences!.getBool(key.toString()) ?? false;

  Future<void> setUserData(UserData user) async {
   await _preferences!.setString('user', json.encode(user.toJson));
  }

  UserData? get getUser {
    var userString = _preferences!.getString('user');

    if (userString != null && userString.isNotEmpty) {
      var user = UserData.fromJson(json.decode(userString));
      return user;
    }

    return null;
  }
}
