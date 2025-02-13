

import 'package:fh/features/home/domain/usecases/add_favorite_movie_usecase.dart';
import 'package:fh/features/home/domain/usecases/get_favorites_movies_usecase.dart.dart';
import 'package:fh/features/home/presentation/bloc/movies_bloc.dart';

import '../../injection.dart';
import 'data/data_sources/local/movies_local_data_source.dart';
import 'data/data_sources/remote/movies_remote_data_source.dart';
import 'data/repositories/movies_repo_impl.dart';
import 'domain/repositories/abstract_movies_repository.dart';
import 'domain/usecases/get_now_playing_movies_usecase.dart.dart';
import 'domain/usecases/get_popular_movies_usecase.dart';
import 'domain/usecases/get_top_rated_movies_usecase.dart';
import 'domain/usecases/remove_favorite_movie_usecase.dart';


initMoviesInjections() {
  ///datasource
  sl.registerLazySingleton<MoviesRemoteDataSource>(
        () => MoviesRemoteDataSourceImpl(dio: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton<MoviesLocalDataSource>(
        () => MoviesLocalDataSourceImpl(),
  );

  ///Repo
  sl.registerLazySingleton<AbstractMoviesRepository>(
        () => MoviesRepositoryImpl(sl(),sl()),
  );

  /// UseCases
  sl.registerLazySingleton(() => GetPopularMoviesUseCase(sl()));
  sl.registerLazySingleton(() => GetTopRatedMoviesUseCase(sl()));
  sl.registerLazySingleton(() => GetNowPlayingMoviesUseCase(sl()));

  sl.registerLazySingleton(() => AddFavoriteMovieUseCase(sl()));
  sl.registerLazySingleton(() => GetFavoritesMoviesUseCase(sl()));
  sl.registerLazySingleton(() => RemoveFavoriteMovieUseCase(sl()));

  /// Bloc
  sl.registerLazySingleton(() => MoviesBloc(
      getPopularMoviesUseCase: sl(),
      getNowPlayingMoviesUseCase: sl(),
      getTopRatedMoviesUseCase: sl(),
    addFavoriteMovieUseCase: sl(),
    getFavoriteMoviesUseCase: sl(),
    removeFavoriteMovieUseCase: sl()
  ));

}
