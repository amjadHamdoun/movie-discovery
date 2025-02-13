

import '../../injection.dart';
import '../shared/data/data_sources/app_shared_prefs.dart';

class Helper {

  static bool isDarkTheme() {
    return sl<AppSharedPrefs>().getIsDarkTheme();
  }
}
