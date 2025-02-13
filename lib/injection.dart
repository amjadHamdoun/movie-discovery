import 'package:fh/core/router/auto_router.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/shared/data/data_sources/app_shared_prefs.dart';
import 'core/shared/presentation/bloc/app_bloc.dart';
import 'core/utils/flavors.dart';

import 'features/home/movies_injections.dart';
import 'features/movie_details/movies_details_injections.dart';
import 'features/search/search_injections.dart';





final sl = GetIt.instance;

///
/// The [init] function is responsible for adding the instances to the graph
///
Future<void> init(Flavor flavor) async {
  //!External

  ///Dio
  sl.registerLazySingleton(
        () {
      final dio = Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 20),
          sendTimeout: const Duration(seconds: 20),
          baseUrl: flavor.baseUrl,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            "Authorization": "Bearer ${flavor.tmdpReadAccessToken}",
          },
         // responseType: ResponseType.plain,
            responseType: ResponseType.json
        ),

      );
      dio.interceptors.add(
        LogInterceptor(
            responseBody:flavor.showErrors,
            requestBody:flavor.showErrors,
            responseHeader: flavor.showErrors,
            requestHeader: flavor.showErrors,
            request: flavor.showErrors,
            error: flavor.showErrors),
      );
      return dio;
    },
  );

  ///DataConnectionChecker
  sl.registerLazySingleton(() => DataConnectionChecker());

  ///AppRouter
  sl.registerLazySingleton(() => AppRouter());

  ///SharedPreferences
  sl.registerSingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });
  await sl.isReady<SharedPreferences>();
  sl.registerFactory<AppSharedPrefs>(() => AppSharedPrefs(sl()));

  sl.registerLazySingleton<AppBloc>(() => AppBloc());
  ///Sections
  initMoviesInjections();
  initSearchInjections();
  initMovieDetailsInjections();









}