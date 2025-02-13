import 'package:dartz/dartz.dart';
import 'package:fh/core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/shared/domin/entities/movie_entity.dart';

import '../../domain/repositories/abstract_search_repository.dart';
import '../data_sources/remote/search_remote_data_source.dart';
import '../models/search_params.dart';


class SearchRepositoryImpl implements AbstractSearchRepository {
  final SearchRemoteDataSource searchRemoteDataSource;


  SearchRepositoryImpl(
    this.searchRemoteDataSource,
  );

  @override
  Future<Either<Failure, List<MovieEntity>>> searchMovies(
      SearchParams params) async {
    try{
         final result = await searchRemoteDataSource.searchMovies(params);
         return  Right(result.results??[]);
    }
    on ServerException catch (e) {
       return Left(Failure(e.error,statusCode: e.statusCode));
    }
  }
}
