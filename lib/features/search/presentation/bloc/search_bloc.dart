import 'dart:async';
import 'package:fh/core/shared/domin/entities/movie_entity.dart';
import 'package:fh/features/search/data/models/search_params.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/enums.dart';
import '../../domain/usecases/search_movies_usecase.dart';


part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMoviesUseCase searchMoviesUseCase;
  List<MovieEntity> movies = [];
  int currentPage = 1;
  bool isFetching = false;
  bool hasReachedMax = false;
  String lastQuery = "";

  SearchBloc({required this.searchMoviesUseCase}) : super(SearchInitial()) {
    on<SearchMoviesEvent>(_onSearchMovies);
    on<LoadMoreMoviesEvent>(_onLoadMoreMovies);
  }

  Future<void> _onSearchMovies(SearchMoviesEvent event, Emitter<SearchState> emit) async {
    if (event.query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());
    currentPage = 1;
    lastQuery = event.query;
    movies.clear();
    hasReachedMax = false; // ✅ Reset pagination flag

    final result = await searchMoviesUseCase(
      SearchParams(pageNumber: currentPage, query: event.query),
    );

    if (emit.isDone) return; // ✅ Prevent emitting after closure

    result.fold(
          (failure) => emit(SearchError(failure.error)),
          (newMovies) {
        movies = newMovies;
        hasReachedMax = newMovies.isEmpty; // ✅ If no results, set max flag
        emit(SearchSuccess(movies, hasReachedMax: hasReachedMax));
      },
    );
  }

  Future<void> _onLoadMoreMovies(LoadMoreMoviesEvent event, Emitter<SearchState> emit) async {
    if (isFetching || hasReachedMax || state is SearchLoading || state is SearchError) return;

    isFetching = true;
    currentPage++;

    final result = await searchMoviesUseCase(
      SearchParams(pageNumber: currentPage, query: lastQuery),
    );

    if (emit.isDone) return; // ✅ Prevent emitting after closure

    result.fold(
          (failure) {
        emit(SearchError(failure.error));
        isFetching = false;
      },
          (newMovies) {
        if (newMovies.isEmpty) {
          hasReachedMax = true; // ✅ Stop pagination
        } else {
          movies.addAll(newMovies);
        }
        emit(SearchSuccess(movies, hasReachedMax: hasReachedMax));
        isFetching = false;
      },
    );
  }
}
