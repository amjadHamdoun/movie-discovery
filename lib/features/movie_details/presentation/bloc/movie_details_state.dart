

part of 'movie_details_bloc.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsLoaded extends MovieDetailsState {
  final MovieDetailsEntity movie;
  final List<VideoEntity> videos;
  MovieDetailsLoaded(this.movie,this.videos);
}

class MovieDetailsError extends MovieDetailsState {
  final ErrorType error;
  MovieDetailsError(this.error);
}
