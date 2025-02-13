
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/helper/helper.dart';
import 'core/router/auto_router.dart';
import 'core/shared/data/data_sources/app_hive.dart';
import 'core/shared/presentation/bloc/app_bloc.dart';
import 'core/theme/theme.dart';
import 'injection.dart' as di;
import 'core/utils/flavors.dart';


Future<void> customAppRunner(final Flavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await dotenv.load(fileName: '.env');
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await di.init(flavor);
  await AppHive.init();

  runApp(EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: ScreenUtilInit(
          designSize: const Size(375, 812),
          splitScreenMode: true,
          minTextAdapt: true,
          child: App(
            appFlavor: flavor,
          ))));
}


class App extends StatefulWidget {
  final Flavor appFlavor;
  const App({required this.appFlavor, super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  AppBloc bloc = di.sl<AppBloc>();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      bloc: bloc,
      builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: getAppRouter.config(
            navigatorObservers: () => [
            ],
          ),

          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: EasyLocalization.of(context)?.currentLocale ?? context.deviceLocale,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode:state.isDarkMode ?ThemeMode.dark: ThemeMode.light,
          builder:  (final context, final child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  viewPadding: EdgeInsets.zero,
                  textScaler: TextScaler.noScaling
              ),
              child: child!),
          // home: const SplashPage(),
        );
      },
    );
  }
}
