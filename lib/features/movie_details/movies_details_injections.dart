
import 'package:fh/features/movie_details/domain/usecases/get_movie_videos_usecase.dart';
import 'package:fh/features/movie_details/presentation/bloc/movie_details_bloc.dart';

import '../../injection.dart';
import 'data/data_sources/remote/movie_details_remote_data_source.dart';
import 'data/repositories/movie_details_repo_impl.dart';
import 'domain/repositories/abstract_movie_details_repository.dart';
import 'domain/usecases/get_movie_details_usecase.dart';



initMovieDetailsInjections() {
  ///datasource
  sl.registerLazySingleton<MovieDetailsRemoteDataSource>(
        () => MovieDetailsRemoteDataSourceImpl(dio: sl(), networkInfo: sl()),
  );


  ///Repo
  sl.registerLazySingleton<AbstractMovieDetailsRepository>(
        () => MovieDetailsRepositoryImpl(sl()),
  );

  /// UseCases
  sl.registerLazySingleton(() => GetMovieDetailsUseCase(sl()));
  sl.registerLazySingleton(() => GetMovieVideosUseCase(sl()));

  /// Bloc
  sl.registerFactory(() => MovieDetailsBloc(
      getMovieDetailsUseCase: sl(),
    getMovieVideosUseCase: sl()
  ));

}
