part of 'movies_bloc.dart';

abstract class MoviesEvent {
  const MoviesEvent();
}

class OnGettingMoviesEvent extends MoviesEvent {
  final int pageNumber;

  const OnGettingMoviesEvent({required this.pageNumber});
}

class OnGettingLocalMoviesEvent extends MoviesEvent {}

class OnAddFavoriteMovieEvent extends MoviesEvent {
  final MovieEntity movie;
  const OnAddFavoriteMovieEvent(this.movie);
}

class OnRemoveFavoriteMovieEvent extends MoviesEvent {
  final MovieEntity movie;
  const OnRemoveFavoriteMovieEvent(this.movie);

}

class OnGetFavoriteMoviesEvent extends MoviesEvent {}



