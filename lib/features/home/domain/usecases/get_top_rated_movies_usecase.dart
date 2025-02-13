import 'package:dartz/dartz.dart';
import 'package:fh/features/home/data/models/movies_params.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/shared/domin/entities/movie_entity.dart';
import '../../../../../core/usecase/usecase.dart';
import '../repositories/abstract_movies_repository.dart';

class GetTopRatedMoviesUseCase extends UseCase<List<MovieEntity>, MoviesParams> {
  final AbstractMoviesRepository repository;

  GetTopRatedMoviesUseCase(this.repository);

  @override
  Future<Either<Failure, List<MovieEntity>>> call(
      MoviesParams params) async {
    final result = await repository.getTopRatedMovies(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}

