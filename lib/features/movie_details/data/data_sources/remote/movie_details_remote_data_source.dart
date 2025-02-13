

import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:fh/core/utils/enums.dart';
import 'package:fh/features/movie_details/data/models/movie_details_params.dart';
import 'package:fh/features/movie_details/data/models/video_model.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/shared/data/models/movie_response_model.dart';
import '../../models/movie_details_model.dart';




abstract class MovieDetailsRemoteDataSource {
  Future<MovieDetailsModel> getMovieDetails(MovieDetailsParams params);
  Future<ApiResponse<List<VideoModel>>> getMovieVideos(MovieDetailsParams params);



}

class MovieDetailsRemoteDataSourceImpl extends MovieDetailsRemoteDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  MovieDetailsRemoteDataSourceImpl({required this.dio, required this.networkInfo});

  @override
  Future<MovieDetailsModel> getMovieDetails(MovieDetailsParams params) async {
    if (await networkInfo.hasConnection) {
      try {
        final result = await dio.get(Constants.getMovieDetailsPath(params.id),);
        return MovieDetailsModel.fromJson(result.data);
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
  Future<ApiResponse<List<VideoModel>>> getMovieVideos(MovieDetailsParams params) async {
    if (await networkInfo.hasConnection) {
      try {
        final result = await dio.get(Constants.getMovieVideosPath(params.id),);

        return ApiResponse.fromJson<List<VideoModel>>(
            result.data, VideoModel.fromJsonList);
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
