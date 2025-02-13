import 'package:fh/core/shared/data/models/movie_model.dart';
import 'package:fh/core/shared/data/models/movie_response_model.dart';

ApiResponse<List<MovieModel>> actualMoviesFailedOrEmptyListData = ApiResponse(
  totalPages: null,
  page: null,
  totalResults: null,
  results: null,
);

ApiResponse<List<MovieModel>> actualMoviesListData = ApiResponse(
  totalResults: null,
  page: null,
  totalPages:null ,
  results: [
    MovieModel(
      id: 278, backdropPath: "/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg",
      title: "The Shawshank Redemption", voteAverage:  8.708,
    ),
  ],
);
