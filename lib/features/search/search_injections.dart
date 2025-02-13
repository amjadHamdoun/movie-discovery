
import 'package:fh/features/search/data/data_sources/remote/search_remote_data_source.dart';
import 'package:fh/features/search/presentation/bloc/search_bloc.dart';

import '../../injection.dart';
import 'data/repositories/search_repo_impl.dart';
import 'domain/repositories/abstract_search_repository.dart';
import 'domain/usecases/search_movies_usecase.dart';



initSearchInjections() {
  ///datasource
  sl.registerLazySingleton<SearchRemoteDataSource>(
        () => SearchRemoteDataSourceImpl(dio: sl(), networkInfo: sl()),
  );


  ///Repo
  sl.registerLazySingleton<AbstractSearchRepository>(
        () => SearchRepositoryImpl(sl()),
  );

  /// UseCases
  sl.registerLazySingleton(() => SearchMoviesUseCase(sl()));


  /// Bloc
  sl.registerFactory(() => SearchBloc(
      searchMoviesUseCase: sl(),
  ));

}
