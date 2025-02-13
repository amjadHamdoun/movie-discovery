import 'package:fh/core/helper/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection.dart';
import '../../data/data_sources/app_shared_prefs.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState(isDarkMode: Helper.isDarkTheme())) {
    on<ToggleThemeEvent>((event, emit) {
      sl<AppSharedPrefs>().setDarkTheme(!state.isDarkMode);
      emit(AppState(isDarkMode: !state.isDarkMode));
    });
  }
}
