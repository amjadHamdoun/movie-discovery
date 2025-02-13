import 'package:dartz/dartz.dart';
import 'package:fh/core/shared/domin/entities/movie_entity.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/search_params.dart';
import '../repositories/abstract_search_repository.dart';

class SearchMoviesUseCase extends UseCase<List<MovieEntity>, SearchParams> {
  final AbstractSearchRepository repository;

  SearchMoviesUseCase(this.repository);

  @override
  Future<Either<Failure, List<MovieEntity>>> call(
      SearchParams params) async {
    final result = await repository.searchMovies(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}

