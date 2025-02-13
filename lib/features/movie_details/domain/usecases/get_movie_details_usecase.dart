import 'package:dartz/dartz.dart';
import 'package:fh/core/shared/domin/entities/movie_entity.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/movie_details_params.dart';
import '../entities/movie_details_entity.dart';
import '../repositories/abstract_movie_details_repository.dart';

class GetMovieDetailsUseCase extends UseCase<MovieDetailsEntity, MovieDetailsParams> {
  final AbstractMovieDetailsRepository repository;

  GetMovieDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, MovieDetailsEntity>> call(
      MovieDetailsParams params) async {
    final result = await repository.getMovieDetails(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}

