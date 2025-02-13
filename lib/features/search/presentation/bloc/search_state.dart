part of 'search_bloc.dart';


abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<MovieEntity> movies;
  final bool hasReachedMax;

  SearchSuccess(this.movies, {this.hasReachedMax = false});
}

class SearchError extends SearchState {
  final ErrorType error;
  SearchError(this.error);
}
