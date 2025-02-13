import 'package:dartz/dartz.dart';
import 'package:fh/core/shared/domin/entities/movie_entity.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/search_params.dart';

abstract class AbstractSearchRepository {

  Future<Either<Failure, List<MovieEntity>>> searchMovies(SearchParams params);


}
