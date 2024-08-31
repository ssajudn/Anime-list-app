import 'package:anime_list/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static SharedPreferences? _database;

  Future<SharedPreferences> get database async {
    if (_database != null) return _database!;

    _database = await SharedPreferences.getInstance();

    return _database!;
  }

  Future<bool> get isDarkMode async {
    final db = await instance.database;

    return db.getBool(Constants.isDarkMode) ?? false;
  }

  Future<bool> setDarkMode(bool isDark) async {
    final db = await instance.database;

    return await db.setBool(Constants.isDarkMode, isDark);
  }

  Future<bool> get isEnglish async {
    final db = await instance.database;

    return db.getBool(Constants.isEnglish) ?? false;
  }

  Future<bool> setIsEnglish(bool isEnglish) async {
    final db = await instance.database;

    return await db.setBool(Constants.isEnglish, isEnglish);
  }

  Future<bool> getIsDarkMode() async {
    final isDark = await DatabaseHelper.instance.isDarkMode;

    return isDark;
  }
}
