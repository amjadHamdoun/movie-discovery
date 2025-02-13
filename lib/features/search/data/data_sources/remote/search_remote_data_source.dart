

import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:fh/core/utils/enums.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/shared/data/models/movie_model.dart';
import '../../../../../core/shared/data/models/movie_response_model.dart';
import '../../models/search_params.dart';




abstract class SearchRemoteDataSource {
  Future<ApiResponse<List<MovieModel>>> searchMovies(SearchParams params);


}

class SearchRemoteDataSourceImpl extends SearchRemoteDataSource {
  final Dio dio;
  final DataConnectionChecker networkInfo;

  SearchRemoteDataSourceImpl({required this.dio, required this.networkInfo});

  @override
  Future<ApiResponse<List<MovieModel>>> searchMovies(SearchParams params) async {
    if (await networkInfo.hasConnection) {
      try {
        final result = await dio.get(Constants.searchMovies,
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
