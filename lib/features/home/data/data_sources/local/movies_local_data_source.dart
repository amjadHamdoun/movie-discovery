

import 'package:fh/core/constants/local_storage_constants.dart';
import 'package:hive/hive.dart';

import '../../../../../core/shared/data/models/movie_model.dart';



abstract class MoviesLocalDataSource {
  List<MovieModel> getPopularMovies();
  List<MovieModel> getTopRatedMovies();
  List<MovieModel> getNowPlayingMovies();
   void putPopularMovies(List<MovieModel> movies);
   void putTopRatedMovies(List<MovieModel> movies);
   void putNowPlayingMovies(List<MovieModel> movies);

}

class MoviesLocalDataSourceImpl extends MoviesLocalDataSource {
  @override
  List<MovieModel> getNowPlayingMovies() {
    final Box moviesBox = Hive.box(HiveKeyConstants.moviesBox);
    final localNowPlayingMovies = moviesBox.get(HiveKeyConstants.nowPlayingMoviesKey);
    final List<MovieModel>? nowPlayingMovies = (localNowPlayingMovies as List?)
        ?.map((e) => e as MovieModel)
        .toList();
    return nowPlayingMovies??[];
  }

  @override
  List<MovieModel> getPopularMovies() {
    final Box moviesBox = Hive.box(HiveKeyConstants.moviesBox);
    final localNowPlayingMovies = moviesBox.get(HiveKeyConstants.popularMoviesKey);
    final List<MovieModel>? popularMovies = (localNowPlayingMovies as List?)
        ?.map((e) => e as MovieModel)
        .toList();
    return popularMovies??[];
  }

  @override
  List<MovieModel> getTopRatedMovies() {
    final Box moviesBox = Hive.box(HiveKeyConstants.moviesBox);
    final localNowPlayingMovies = moviesBox.get(HiveKeyConstants.topRatedMoviesKey);
    final List<MovieModel>? topRatedMovies = (localNowPlayingMovies as List?)
        ?.map((e) => e as MovieModel)
        .toList();
    return topRatedMovies??[];
  }

  @override
  void putNowPlayingMovies(List<MovieModel> movies) {
   final Box moviesBox = Hive.box(HiveKeyConstants.moviesBox);
    moviesBox.put(HiveKeyConstants.nowPlayingMoviesKey, movies);
  }

  @override
  void putPopularMovies(List<MovieModel> movies) {
    final Box moviesBox = Hive.box(HiveKeyConstants.moviesBox);
    moviesBox.put(HiveKeyConstants.popularMoviesKey, movies);
  }

  @override
  void putTopRatedMovies(List<MovieModel> movies) {
    final Box moviesBox = Hive.box(HiveKeyConstants.moviesBox);
    moviesBox.put(HiveKeyConstants.topRatedMoviesKey, movies);
  }

}
