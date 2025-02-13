
import 'package:fh/features/home/data/data_sources/local/movies_local_data_source.dart';
import 'package:fh/features/home/data/data_sources/remote/movies_remote_data_source.dart';
import 'package:fh/features/home/data/models/movies_params.dart';
import 'package:fh/features/home/data/repositories/movies_repo_impl.dart';
import 'package:fh/features/home/domain/repositories/abstract_movies_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../data_sources/movies_api_test.mocks.dart';
import 'mock_data/actual_movies_data.dart';
import 'mock_data/expected_movies_data.dart';
import 'movies_repository_impl_test.mocks.dart';

@GenerateMocks([MoviesRemoteDataSourceImpl,MoviesLocalDataSourceImpl])
void main() {
  MoviesParams moviesParams = MoviesParams(pageNumber: 1, localData: false);
  late MoviesRemoteDataSourceImpl remoteDataSourceImpl;
  late MoviesLocalDataSourceImpl localDataSourceImpl;

  late MockDataConnectionChecker mockDataConnectionChecker;

  late AbstractMoviesRepository moviesRepositoryImpl;
  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    localDataSourceImpl = MockMoviesLocalDataSourceImpl();
    remoteDataSourceImpl = MockMoviesRemoteDataSourceImpl();
    moviesRepositoryImpl = MoviesRepositoryImpl(remoteDataSourceImpl,localDataSourceImpl);
  });

  group("Test movies_rep_impl", () {
    test("Get Top Rated Movies - Failed Case, Empty Or Null Api response",
        () async {
          when(mockDataConnectionChecker.hasConnection).thenAnswer((_)async => true);

          when(remoteDataSourceImpl.getTopRatedMovies(moviesParams))
          .thenAnswer((realInvocation) async {
        return actualMoviesFailedOrEmptyListData;
      });
      var result;
      try {
        result = await moviesRepositoryImpl.getTopRatedMovies(moviesParams);
      } catch (e) {
        result = e;
      }
      expect(result.value, expectedMoviesEmptyListData.value);
    });

    test("Get Top Rated Movies - Success Case", () async {
    //  when(mockDataConnectionChecker.hasConnection).thenAnswer((_)async => true);

      when(remoteDataSourceImpl.getTopRatedMovies(moviesParams))
          .thenAnswer((realInvocation) async {
        return actualMoviesListData;
      });
      var result;
      try {
        result = await moviesRepositoryImpl.getTopRatedMovies(moviesParams);
      } catch (e) {
        result = e;
      }
      expect(result.value.first.id, expectedMoviesListData.value.first.id);
    });
  });
}
