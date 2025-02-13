part of 'movies_bloc.dart';

abstract class MoviesEvent {
  const MoviesEvent();
}

class OnGettingMoviesEvent extends MoviesEvent {
  final int pageNumber;

  const OnGettingMoviesEvent({required this.pageNumber});
}

class OnGettingLocalMoviesEvent extends MoviesEvent {}


