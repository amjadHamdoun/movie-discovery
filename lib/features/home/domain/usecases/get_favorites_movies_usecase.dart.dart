import 'package:dartz/dartz.dart';
import 'package:fh/core/shared/domin/entities/movie_entity.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/usecase.dart';
import '../repositories/abstract_movies_repository.dart';

class GetFavoritesMoviesUseCase extends UseCase<List<MovieEntity>, NoParams> {
  final AbstractMoviesRepository repository;

  GetFavoritesMoviesUseCase(this.repository);

  @override
  Future<Either<Failure, List<MovieEntity>>> call(
      params) async {
    final result =  repository.getFavoritesMovies();
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}

