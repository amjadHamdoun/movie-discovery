import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:fh/core/constants/constants.dart';
import 'package:fh/core/error/exceptions.dart';
import 'package:fh/core/utils/enums.dart';
import 'package:fh/features/home/data/data_sources/remote/movies_remote_data_source.dart';
import 'package:fh/features/home/data/models/movies_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mock_data/actual_movie_json.dart';
import 'mock_data/expected_movies_data.dart';
import 'movies_api_test.mocks.dart';


@GenerateMocks([Dio,DataConnectionChecker])
void main() {
  MoviesParams moviesParams = MoviesParams(pageNumber: 1,localData: false);

  late MockDio mockDio;
  late MockDataConnectionChecker mockDataConnectionChecker;

  late MoviesRemoteDataSource moviesRemoteDataSource;
  setUp(() {
    mockDio = MockDio();
    mockDataConnectionChecker = MockDataConnectionChecker();
    moviesRemoteDataSource = MoviesRemoteDataSourceImpl( dio: mockDio,networkInfo: mockDataConnectionChecker);
  });

  RequestOptions requestOptions = RequestOptions();

  group("Test MOVIES API", () {
    test("Get Top Rated Movies - Failed Case", () async {
      when(mockDataConnectionChecker.hasConnection).thenAnswer((_)async => true);

      when(mockDio.get(Constants.topRatedMovies)).thenThrow(const ServerException(ErrorType.error,statusCode: 400));

      expect(() async => await moviesRemoteDataSource.getTopRatedMovies(moviesParams), throwsA(isA<ServerException>()));

    });

    test("Get Top Rated Movies - Empty Case", () async {
      when(mockDataConnectionChecker.hasConnection).thenAnswer((_)async => true);

      when(mockDio.get(Constants.topRatedMovies,queryParameters: moviesParams.toJson()))
          .thenAnswer((realInvocation) async {
        // Actual result
        return Response(
          requestOptions: requestOptions,
          statusCode: 200,
          data: actualMoviesEmptyJson,
        );
      });
      var result;
      try {
        // Compare actual result with expected result
        result = await moviesRemoteDataSource.getTopRatedMovies(moviesParams);
      }on ServerException catch (e) {
        result = e;
      }

      expect(result.results?.isEmpty, expectedMoviesEmptyListData.results?.isEmpty);
    });

    test("Get Top Rated Movies ", () async {
      when(mockDataConnectionChecker.hasConnection).thenAnswer((_)async => true);

      when(mockDio.get(Constants.topRatedMovies,queryParameters:moviesParams.toJson() ))
          .thenAnswer((realInvocation) async {
        // Actual result
        return Response(
          requestOptions: requestOptions,
          statusCode: 200,
          data: actualMoviesListJson,
        );
      });
      var result;
      try {
        // Compare actual result with expected result
        result = await moviesRemoteDataSource.getTopRatedMovies(moviesParams);
      } on ServerException catch (e) {
        result = e;
      }

      expect(result.results?.first.id, expectedMoviesListData.results?.first.id);
    });
  });
}
