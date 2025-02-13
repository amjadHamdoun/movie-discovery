import 'package:dartz/dartz.dart';
import 'package:fh/core/shared/domin/entities/movie_entity.dart';

import '../../../../../core/error/failures.dart';
import '../../data/models/movies_params.dart';



abstract class AbstractMoviesRepository {
  //
  Future<Either<Failure, List<MovieEntity>>> getPopularMovies(MoviesParams params);
  Future<Either<Failure, List<MovieEntity>>> getTopRatedMovies(MoviesParams params);
  Future<Either<Failure, List<MovieEntity>>> getNowPlayingMovies(MoviesParams params);

}
