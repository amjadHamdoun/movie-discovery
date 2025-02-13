import 'package:dartz/dartz.dart';
import 'package:fh/core/error/exceptions.dart';
import 'package:fh/core/shared/data/models/movie_model.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/shared/domin/entities/movie_entity.dart';
import '../../domain/repositories/abstract_movies_repository.dart';
import '../data_sources/local/movies_local_data_source.dart';
import '../data_sources/remote/movies_remote_data_source.dart';
import '../models/movies_params.dart';


class MoviesRepositoryImpl implements AbstractMoviesRepository {
  final MoviesRemoteDataSource moviesRemoteDataSource;
  final MoviesLocalDataSource moviesLocalDataSource;

  MoviesRepositoryImpl(
      this.moviesRemoteDataSource,
      this.moviesLocalDataSource
      );

  @override
  Future<Either<Failure, List<MovieEntity>>> getPopularMovies(
      MoviesParams params) async {
    try{
      if(!params.localData){
        final result = await moviesRemoteDataSource.getPopularMovies(params);
        moviesLocalDataSource.putPopularMovies(result.results??[]);
        return  Right(result.results??[]);
      }
      else{
        final result =  moviesLocalDataSource.getPopularMovies();
        return  Right(result);
      }
    }
    on ServerException catch(e){

      return Left(Failure(e.error,statusCode: e.statusCode));
    }

  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getNowPlayingMovies(MoviesParams params) async {
    try{

      if(!params.localData){
        final result = await moviesRemoteDataSource.getNowPlayingMovies(params);
        moviesLocalDataSource.putNowPlayingMovies(result.results??[]);
        return  Right(result.results??[]);
      }
      else{
        final result =  moviesLocalDataSource.getNowPlayingMovies();
        return  Right(result);
      }
    }
    on ServerException catch(e){

      return Left(Failure(e.error,statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getTopRatedMovies(MoviesParams params) async {
    try{
      if(!params.localData){
        final result = await moviesRemoteDataSource.getTopRatedMovies(params);
        moviesLocalDataSource.putTopRatedMovies(result.results??[]);
        return  Right(result.results??[]);
      }
      else{
        final result =  moviesLocalDataSource.getTopRatedMovies();
        return  Right(result);
      }
    }
    on ServerException catch(e){
      return Left(Failure(e.error,statusCode: e.statusCode));
    }
  }

  @override
  Either<Failure, void> addMovieToFavorite(MovieEntity movie) {
    try{
      moviesLocalDataSource.addMovieToFavorites(
          MovieModel(backdropPath: movie.image,
              voteAverage: movie.rate, title: movie.movieTitle, id: movie.movieId)
      );
      return   const Right(null);
    }
    on ServerException catch(e){
      return Left(Failure(e.error,statusCode: e.statusCode));
    }
  }

  @override
  Either<Failure, List<MovieEntity>> getFavoritesMovies() {
    try{
      final result =  moviesLocalDataSource.getFavoritesMovies();
      return Right(result);
    }
    on ServerException catch(e){
      return Left(Failure(e.error,statusCode: e.statusCode));
    }
  }

  @override
  Either<Failure, void> removeMovieFromFavorite(MovieEntity movie) {
    try{
      moviesLocalDataSource.removeMovieFromFavorites(
          MovieModel(backdropPath: movie.image,
              voteAverage: movie.rate, title: movie.movieTitle, id: movie.movieId)
      );
      return const Right(null);
    }
    on ServerException catch(e){
      return Left(Failure(e.error,statusCode: e.statusCode));
    }
  }
}
