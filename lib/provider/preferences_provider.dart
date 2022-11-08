import 'package:flutter/material.dart';
import 'package:makan_apa_app/common/styles.dart';
import 'package:makan_apa_app/data/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getTheme();
    _getNotificationRestaurant();
  }

  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  bool _isNotificationRestaurant = false;

  bool get isNotificationRestaurant => _isNotificationRestaurant;

  void _getTheme() async {
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }

  void enableDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getTheme();
  }

  void _getNotificationRestaurant() async {
    _isNotificationRestaurant =
        await preferencesHelper.isNotificationRestaurant;
    notifyListeners();
  }

  void enableNotificationRestaurant(bool value) {
    preferencesHelper.setNotificationRestaurant(value);
    _getNotificationRestaurant();
  }
}
