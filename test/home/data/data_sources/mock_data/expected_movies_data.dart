
import 'package:fh/core/shared/data/models/movie_model.dart';
import 'package:fh/core/shared/data/models/movie_response_model.dart';

ApiResponse<List<MovieModel>> expectedMoviesEmptyListData = ApiResponse(
  page: 1,
  totalPages: 0,
  totalResults:0 ,
  results: [],
);

ApiResponse<List<MovieModel>> expectedMoviesListData = ApiResponse(
  page: 1,
  totalPages: 498,
  totalResults:9960 ,
  results: [
    MovieModel(
      id: 278, backdropPath: "/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg",
      title: "The Shawshank Redemption", voteAverage:  8.708,
    ),
  ],
);
