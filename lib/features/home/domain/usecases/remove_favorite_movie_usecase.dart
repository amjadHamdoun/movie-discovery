


import 'package:dartz/dartz.dart';
import 'package:fh/core/shared/domin/entities/movie_entity.dart';
import 'package:fh/features/home/domain/repositories/abstract_movies_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';

class RemoveFavoriteMovieUseCase extends UseCase<void, MovieEntity> {

  final AbstractMoviesRepository repository;
  RemoveFavoriteMovieUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(MovieEntity params) async {
    return repository.removeMovieFromFavorite(params);
  }
}
