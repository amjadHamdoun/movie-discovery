import 'package:fh/core/shared/domin/entities/movie_entity.dart';
import 'package:fh/core/usecase/usecase.dart';
import 'package:fh/core/utils/enums.dart';
import 'package:fh/features/home/domain/usecases/get_favorites_movies_usecase.dart.dart';
import 'package:fh/features/home/domain/usecases/get_now_playing_movies_usecase.dart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/movies_params.dart';
import '../../domain/usecases/add_favorite_movie_usecase.dart';
import '../../domain/usecases/get_popular_movies_usecase.dart';
import '../../domain/usecases/get_top_rated_movies_usecase.dart';
import '../../domain/usecases/remove_favorite_movie_usecase.dart';


part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  final GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;
  final GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase;
  final AddFavoriteMovieUseCase addFavoriteMovieUseCase;
  final RemoveFavoriteMovieUseCase removeFavoriteMovieUseCase;
  final GetFavoritesMoviesUseCase getFavoriteMoviesUseCase;

  final List<MovieEntity> _popularMovies = [];
  final List<MovieEntity> _topRatedMovies = [];
  final List<MovieEntity> _nowPlayingMovies = [];
  final List<MovieEntity> _favoriteMovies = [];


  MoviesBloc({
    required this.getPopularMoviesUseCase,
    required this.getTopRatedMoviesUseCase,
    required this.getNowPlayingMoviesUseCase,
    required this.addFavoriteMovieUseCase,
    required this.removeFavoriteMovieUseCase,
    required this.getFavoriteMoviesUseCase,

  }) : super(LoadingGetMoviesState()) {
    on<OnGettingMoviesEvent>(_onGettingMoviesEvent);
    on<OnGettingLocalMoviesEvent>(_onGettingLocalMoviesDataEvent);
    on<OnAddFavoriteMovieEvent>(_onAddFavoriteMovieEvent);
    on<OnRemoveFavoriteMovieEvent>(_onRemoveFavoriteMovieEvent);
    on<OnGetFavoriteMoviesEvent>(_onGetFavoriteMoviesEvent);

  }

  Future<void> _onGettingMoviesEvent(
      OnGettingMoviesEvent event, Emitter<MoviesState> emit) async {
    emit(LoadingGetMoviesState());

    final params = MoviesParams(pageNumber: event.pageNumber,localData: false);

    // Fetch all movies concurrently
    final results = await Future.wait([
      getPopularMoviesUseCase.call(params),
      getTopRatedMoviesUseCase.call(params),
      getNowPlayingMoviesUseCase.call(params),
    ]);

    // Extract results
    final resultPopularMovies = results[0];
    final resultTopRatedMovies = results[1];
    final resultNowPlayingMovies = results[2];

    // Initialize error message
    ErrorType? error;

    resultPopularMovies.fold(
          (failure) => error ??= failure.error,
          (movies) => _popularMovies.addAll(movies),
    );

    resultTopRatedMovies.fold(
          (failure) => error ??= failure.error,
          (movies) => _topRatedMovies.addAll(movies),
    );

    resultNowPlayingMovies.fold(
          (failure) => error ??= failure.error,
          (movies) => _nowPlayingMovies.addAll(movies),
    );

    // If there's an error, emit error state
    if (error != null) {
      emit(ErrorGetMoviesState(error!));
      add(OnGettingLocalMoviesEvent());
      return;
    }

    // Emit success state with updated movies
    if(_nowPlayingMovies.isNotEmpty&&_popularMovies.isNotEmpty&&_topRatedMovies.isNotEmpty)
      {
        emit(SuccessGetMoviesState(
          nowPlayingMovies: List.unmodifiable(_nowPlayingMovies),
          popularMovies: List.unmodifiable(_popularMovies),
          topRatedMovies: List.unmodifiable(_topRatedMovies),
          favoriteMovies: List.unmodifiable(_favoriteMovies),
        ));
        add(OnGetFavoriteMoviesEvent());
      }
    else{
      emit(ErrorGetMoviesState(ErrorType.noDataFound));
    }

  }

  Future<void> _onGettingLocalMoviesDataEvent(
      OnGettingLocalMoviesEvent event, Emitter<MoviesState> emit) async {
    final params = MoviesParams(pageNumber: 1,localData: true);
    // Fetch all movies concurrently
    final results = await Future.wait([
      getPopularMoviesUseCase.call(params),
      getTopRatedMoviesUseCase.call(params),
      getNowPlayingMoviesUseCase.call(params),
    ]);

    // Extract results
    final resultPopularMovies = results[0];
    final resultTopRatedMovies = results[1];
    final resultNowPlayingMovies = results[2];

    // Initialize error message
    ErrorType? error;

    resultPopularMovies.fold(
          (failure) => error ??= failure.error,
          (movies) => _popularMovies.addAll(movies),
    );

    resultTopRatedMovies.fold(
          (failure) => error ??= failure.error,
          (movies) => _topRatedMovies.addAll(movies),
    );

    resultNowPlayingMovies.fold(
          (failure) => error ??= failure.error,
          (movies) => _nowPlayingMovies.addAll(movies),
    );

    // If there's an error, emit error state
    if (error != null) {
      emit(ErrorGetMoviesState(error!));
      return;
    }
    // Emit success state with updated movies
    if(_nowPlayingMovies.isNotEmpty&&_popularMovies.isNotEmpty&&_topRatedMovies.isNotEmpty)
      {
        emit(SuccessGetMoviesState(
          nowPlayingMovies: _nowPlayingMovies,
          popularMovies: _popularMovies,
          topRatedMovies: _topRatedMovies,
          favoriteMovies: _favoriteMovies
        ));
        add(OnGetFavoriteMoviesEvent());
      }


  }

  Future<void> _onAddFavoriteMovieEvent(
      OnAddFavoriteMovieEvent event, Emitter<MoviesState> emit) async {
    await addFavoriteMovieUseCase.call(event.movie);
    add(OnGetFavoriteMoviesEvent());
  }

  Future<void> _onRemoveFavoriteMovieEvent(
      OnRemoveFavoriteMovieEvent event, Emitter<MoviesState> emit) async {
    await removeFavoriteMovieUseCase.call(event.movie);
    add(OnGetFavoriteMoviesEvent());
  }

  Future<void> _onGetFavoriteMoviesEvent(
      OnGetFavoriteMoviesEvent event, Emitter<MoviesState> emit) async {
    final result = await getFavoriteMoviesUseCase.call(NoParams());
    result.fold(
          (failure) => emit(ErrorGetMoviesState(failure.error)),
          (movies) {
        _favoriteMovies.clear();
        _favoriteMovies.addAll(movies);
        emit(SuccessGetMoviesState(
          nowPlayingMovies: List.unmodifiable(_nowPlayingMovies),
          popularMovies: List.unmodifiable(_popularMovies),
          topRatedMovies: List.unmodifiable(_topRatedMovies),
          favoriteMovies: List.unmodifiable(_favoriteMovies),
        ));
      },
    );
  }

}
