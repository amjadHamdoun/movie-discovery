
import 'package:fh/core/constants/local_storage_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppSharedPrefs {
  final SharedPreferences _preferences;

  AppSharedPrefs(this._preferences);



  bool getIsDarkTheme() {
    return _preferences.getBool(LocalKeyConstants.themeKey) ?? false;
  }

  void setDarkTheme(bool isDark) {
    _preferences.setBool(LocalKeyConstants.themeKey, isDark);
  }
}
