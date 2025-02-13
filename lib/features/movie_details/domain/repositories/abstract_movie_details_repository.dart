import 'package:dartz/dartz.dart';
import 'package:fh/features/movie_details/data/models/movie_details_params.dart';
import 'package:fh/features/movie_details/domain/entities/video_entity.dart';

import '../../../../core/error/failures.dart';
import '../entities/movie_details_entity.dart';

abstract class AbstractMovieDetailsRepository {

  Future<Either<Failure, MovieDetailsEntity>> getMovieDetails(MovieDetailsParams params);

  Future<Either<Failure, List<VideoEntity>>> getMovieVideos(MovieDetailsParams params);

}
