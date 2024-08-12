import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static final SharedPreferencesService _instance = SharedPreferencesService._internal();

  factory SharedPreferencesService() {
    return _instance;
  }

  SharedPreferencesService._internal();

  SharedPreferences? _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Save a boolean value
  Future<void> setBool(String key, bool value) async {
    await _preferences?.setBool(key, value);
  }

  // Get a boolean value
  bool getBool(String key, {bool defaultValue = false}) {
    return _preferences?.getBool(key) ?? defaultValue;
  }

  // Save a string value
  Future<void> setString(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  // Get a string value
  String getString(String key, {String defaultValue = ''}) {
    return _preferences?.getString(key) ?? defaultValue;
  }

  // Save an integer value
  Future<void> setInt(String key, int value) async {
    await _preferences?.setInt(key, value);
  }

  // Get an integer value
  int getInt(String key, {int defaultValue = 0}) {
    return _preferences?.getInt(key) ?? defaultValue;
  }

  // Clear a specific key
  Future<void> clearKey(String key) async {
    await _preferences?.remove(key);
  }

  // Clear all preferences
  Future<void> clearAll() async {
    await _preferences?.clear();
  }
}
