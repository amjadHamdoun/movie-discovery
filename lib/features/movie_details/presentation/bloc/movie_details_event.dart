part of 'movie_details_bloc.dart';

abstract class MovieDetailsEvent {}

class FetchMovieDetailsEvent extends MovieDetailsEvent {
  final int movieId;
  FetchMovieDetailsEvent(this.movieId);
}
