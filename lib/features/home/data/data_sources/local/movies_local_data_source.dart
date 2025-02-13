

import 'package:fh/core/constants/local_storage_constants.dart';
import 'package:hive/hive.dart';

import '../../../../../core/shared/data/models/movie_model.dart';



abstract class MoviesLocalDataSource {
  List<MovieModel> getPopularMovies();
  List<MovieModel> getTopRatedMovies();
  List<MovieModel> getNowPlayingMovies();
  List<MovieModel> getFavoritesMovies();
   void putPopularMovies(List<MovieModel> movies);
   void putTopRatedMovies(List<MovieModel> movies);
   void putNowPlayingMovies(List<MovieModel> movies);
  void addMovieToFavorites(MovieModel movie);
  void removeMovieFromFavorites(MovieModel movie);


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

  @override
  void removeMovieFromFavorites(MovieModel movie) {
    final Box moviesBox = Hive.box(HiveKeyConstants.moviesBox);
    List<MovieModel> favoritesMovies =getFavoritesMovies();
    favoritesMovies.remove(movie);
    moviesBox.put(HiveKeyConstants.favoritesMoviesKey, favoritesMovies);
  }

  @override
  void addMovieToFavorites(MovieModel movie) {
      final Box moviesBox = Hive.box(HiveKeyConstants.moviesBox);
      List<MovieModel> favoritesMovies =getFavoritesMovies();
      favoritesMovies.add(movie);
      moviesBox.put(HiveKeyConstants.favoritesMoviesKey, favoritesMovies);
  }

  @override
  List<MovieModel> getFavoritesMovies() {
    final Box moviesBox = Hive.box(HiveKeyConstants.moviesBox);
    final localFavoritesMovies = moviesBox.get(HiveKeyConstants.favoritesMoviesKey);
    final List<MovieModel>? favoritesMovies = (localFavoritesMovies as List?)
        ?.map((e) => e as MovieModel)
        .toList();
    return favoritesMovies??[];
  }

}
