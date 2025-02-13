

import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:fh/core/utils/enums.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/shared/data/models/movie_model.dart';
import '../../../../../core/shared/data/models/movie_response_model.dart';
import '../../models/movies_params.dart';




abstract class MoviesRemoteDataSource {
  Future<ApiResponse<List<MovieModel>>> getPopularMovies(MoviesParams params);
  Future<ApiResponse<List<MovieModel>>> getTopRatedMovies(MoviesParams params);
  Future<ApiResponse<List<MovieModel>>> getNowPlayingMovies(MoviesParams params);

}

class MoviesRemoteDataSourceImpl extends MoviesRemoteDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  MoviesRemoteDataSourceImpl({required this.dio, required this.networkInfo});

  @override
  Future<ApiResponse<List<MovieModel>>> getPopularMovies(MoviesParams params) async {
    if (await networkInfo.hasConnection) {
      try {
        final result = await dio.get(Constants.popularMovies,
          queryParameters: params.toJson()
        );
        return ApiResponse.fromJson<List<MovieModel>>(
            result.data, MovieModel.fromJsonList);
      } on DioException catch (ex) {
        if (ex.type == DioExceptionType.connectionTimeout) {
          throw ServerException(ErrorType.connectionTimeout,statusCode:  ex.response?.statusCode);
        } else if (ex.type == DioExceptionType.receiveTimeout) {
          throw ServerException(ErrorType.connectionTimeout,statusCode:  ex.response?.statusCode);
        }
        else{
          throw ServerException(ErrorType.error,statusCode:  ex.response?.statusCode);

        }
      } catch (e) {
        throw const ServerException(ErrorType.error);
      }
    } else {
      throw const ServerException(ErrorType.networkError);
    }
  }

  @override
  Future<ApiResponse<List<MovieModel>>> getTopRatedMovies(MoviesParams params) async {
    if (await networkInfo.hasConnection) {
      try {
        final result = await dio.get(Constants.topRatedMovies,
            queryParameters: params.toJson()
        );
        return ApiResponse.fromJson<List<MovieModel>>(
            result.data, MovieModel.fromJsonList);
      } on DioException catch (ex) {
        if (ex.type == DioExceptionType.connectionTimeout) {
          throw ServerException(ErrorType.connectionTimeout,statusCode:  ex.response?.statusCode);
        } else if (ex.type == DioExceptionType.receiveTimeout) {
          throw ServerException(ErrorType.connectionTimeout,statusCode:  ex.response?.statusCode);
        }
        else{
          throw ServerException(ErrorType.error,statusCode:  ex.response?.statusCode);

        }
      } catch (e) {
        throw const ServerException(ErrorType.error);
      }
    } else {

      throw const ServerException(ErrorType.networkError);
    }
  }

  @override
  Future<ApiResponse<List<MovieModel>>> getNowPlayingMovies(MoviesParams params) async {
    if (await networkInfo.hasConnection) {
      try {
        final result = await dio.get(Constants.nowPlayingMovies,
            queryParameters: params.toJson()
        );
        return ApiResponse.fromJson<List<MovieModel>>(
            result.data, MovieModel.fromJsonList);
      } on DioException catch (ex) {
        if (ex.type == DioExceptionType.connectionTimeout) {
          throw ServerException(ErrorType.connectionTimeout,statusCode:  ex.response?.statusCode);
        } else if (ex.type == DioExceptionType.receiveTimeout) {
          throw ServerException(ErrorType.connectionTimeout,statusCode:  ex.response?.statusCode);
        }
        else{
          throw ServerException(ErrorType.error,statusCode:  ex.response?.statusCode);

        }
      } catch (e) {
        throw const ServerException(ErrorType.error);
      }
    } else {
      throw const ServerException(ErrorType.networkError);
    }
  }


}
