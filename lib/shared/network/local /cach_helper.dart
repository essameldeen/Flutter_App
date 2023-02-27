import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool?> saveData(
      {required String key, required dynamic value}) async {
    if (value is String) {
      return await sharedPreferences?.setString(key, value);
    } else if (value is bool) {
      return await sharedPreferences?.setBool(key, value);
    }

    return await sharedPreferences?.setDouble(key, value);
  }

  static dynamic getData(String key) {
    return sharedPreferences?.get(key);
  }

  static bool? getBoolData(String key) {
    return sharedPreferences?.getBool(key);
  }

  static Future<bool?> clearData(String key) async {
    return await sharedPreferences?.remove(key);
  }
}
