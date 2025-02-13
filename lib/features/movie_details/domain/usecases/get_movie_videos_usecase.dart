import 'package:dartz/dartz.dart';
import 'package:fh/features/movie_details/domain/entities/video_entity.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/movie_details_params.dart';
import '../repositories/abstract_movie_details_repository.dart';

class GetMovieVideosUseCase extends UseCase<List<VideoEntity>, MovieDetailsParams> {
  final AbstractMovieDetailsRepository repository;

  GetMovieVideosUseCase(this.repository);

  @override
  Future<Either<Failure, List<VideoEntity>>> call(
      MovieDetailsParams params) async {
    final result = await repository.getMovieVideos(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}

