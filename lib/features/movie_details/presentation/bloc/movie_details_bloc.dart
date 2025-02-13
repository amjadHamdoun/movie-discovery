
import 'package:fh/features/movie_details/data/models/movie_details_params.dart';
import 'package:fh/features/movie_details/domain/entities/video_entity.dart';
import 'package:fh/features/movie_details/domain/usecases/get_movie_details_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/enums.dart';
import '../../domain/entities/movie_details_entity.dart';
import '../../domain/usecases/get_movie_videos_usecase.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieDetailsUseCase getMovieDetailsUseCase;
  final GetMovieVideosUseCase getMovieVideosUseCase;
  MovieDetailsBloc({required this.getMovieDetailsUseCase,required this.getMovieVideosUseCase})
      : super(MovieDetailsInitial()) {
    on<FetchMovieDetailsEvent>(_onFetchMovieDetails);
  }

  Future<void> _onFetchMovieDetails(
      FetchMovieDetailsEvent event, Emitter<MovieDetailsState> emit) async {
    emit(MovieDetailsLoading());
     List<VideoEntity> videos=[];
    final result = await getMovieDetailsUseCase(MovieDetailsParams(id: event.movieId));
    final resultVideos = await getMovieVideosUseCase(MovieDetailsParams(id: event.movieId));

    resultVideos.fold(
          (failure) => emit(MovieDetailsError(failure.error)),
          (movieDetails) => (videos= movieDetails)
    );

    result.fold(
          (failure) => emit(MovieDetailsError(failure.error)),
          (movieDetails) => emit(MovieDetailsLoaded(movieDetails,videos)),
    );
  }
}
