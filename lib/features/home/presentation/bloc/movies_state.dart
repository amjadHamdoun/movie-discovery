part of 'movies_bloc.dart';

abstract class MoviesState {
  const MoviesState();
}

///Popular Movies
class LoadingGetMoviesState extends MoviesState {}

class ErrorGetMoviesState extends MoviesState {
  final ErrorType type;
  ErrorGetMoviesState(this.type);
}

class SuccessGetMoviesState extends MoviesState {
  final List<MovieEntity> popularMovies;
  final List<MovieEntity> topRatedMovies;
  final List<MovieEntity> nowPlayingMovies;

  SuccessGetMoviesState({required this.nowPlayingMovies,required this.topRatedMovies,
   required this.popularMovies
  });
}



