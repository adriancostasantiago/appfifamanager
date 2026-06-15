import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeController = ThemeController();

class ThemeController extends ChangeNotifier {
  static const _themeKey = 'is_dark_mode';

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  bool get isDark => _themeMode == ThemeMode.dark;

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    final isDark = prefs.getBool(_themeKey);

    if (isDark != null) {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    }

    notifyListeners();
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();

    _themeMode = _themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;

    await prefs.setBool(_themeKey, _themeMode == ThemeMode.dark);

    notifyListeners();
  }
}
