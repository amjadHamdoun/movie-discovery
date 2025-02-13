import 'package:fh/core/shared/domin/entities/movie_entity.dart';
import 'package:fh/core/utils/enums.dart';
import 'package:fh/features/home/domain/usecases/get_now_playing_movies_usecase.dart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/movies_params.dart';
import '../../domain/usecases/get_popular_movies_usecase.dart';
import '../../domain/usecases/get_top_rated_movies_usecase.dart';


part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  final GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;
  final GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase;

  final List<MovieEntity> _popularMovies = [];
  final List<MovieEntity> _topRatedMovies = [];
  final List<MovieEntity> _nowPlayingMovies = [];

  MoviesBloc({
    required this.getPopularMoviesUseCase,
    required this.getTopRatedMoviesUseCase,
    required this.getNowPlayingMoviesUseCase,
  }) : super(LoadingGetMoviesState()) {
    on<OnGettingMoviesEvent>(_onGettingMoviesEvent);
    on<OnGettingLocalMoviesEvent>(_onGettingLocalMoviesDataEvent);

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
        ));
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
        ));
      }
    // else{
    //   emit(ErrorGetMoviesState(ErrorType.noDataFound));
    // }

  }
}
