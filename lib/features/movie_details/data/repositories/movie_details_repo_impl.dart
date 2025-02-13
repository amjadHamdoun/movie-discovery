import 'package:dartz/dartz.dart';
import 'package:fh/core/error/exceptions.dart';
import 'package:fh/features/movie_details/domain/entities/video_entity.dart';
import '../../../../core/error/failures.dart';

import '../../domain/entities/movie_details_entity.dart';
import '../../domain/repositories/abstract_movie_details_repository.dart';
import '../data_sources/remote/movie_details_remote_data_source.dart';
import '../models/movie_details_params.dart';



class MovieDetailsRepositoryImpl implements AbstractMovieDetailsRepository {
  final MovieDetailsRemoteDataSource movieDetailsRemoteDataSource;


  MovieDetailsRepositoryImpl(
    this.movieDetailsRemoteDataSource,
  );

  @override
  Future<Either<Failure, MovieDetailsEntity>> getMovieDetails(
      MovieDetailsParams params) async {
    try{
         final result = await movieDetailsRemoteDataSource.getMovieDetails(params);
         return  Right(result);
    }
    on ServerException catch (e) {
       return Left(Failure(e.error,statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<VideoEntity>>> getMovieVideos(
      MovieDetailsParams params) async {
    try{
      final result = await movieDetailsRemoteDataSource.getMovieVideos(params);
      return  Right(result.results??[]);
    }
    on ServerException catch (e) {
      return Left(Failure(e.error,statusCode: e.statusCode));
    }
  }
}
