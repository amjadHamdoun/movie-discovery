import 'package:dartz/dartz.dart';
import 'package:fh/core/shared/domin/entities/movie_entity.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../data/models/movies_params.dart';
import '../repositories/abstract_movies_repository.dart';

class GetNowPlayingMoviesUseCase extends UseCase<List<MovieEntity>, MoviesParams> {
  final AbstractMoviesRepository repository;

  GetNowPlayingMoviesUseCase(this.repository);

  @override
  Future<Either<Failure, List<MovieEntity>>> call(
      MoviesParams params) async {
    final result = await repository.getNowPlayingMovies(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}

