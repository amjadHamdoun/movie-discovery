import 'package:dartz/dartz.dart';
import 'package:fh/core/error/failures.dart';
import 'package:fh/core/shared/data/models/movie_model.dart';

Right<Failure, List<MovieModel>> expectedMoviesEmptyListData = const Right(<MovieModel>[]);

Right<Failure, List<MovieModel>> expectedMoviesListData = Right(
  <MovieModel>[
    MovieModel(
      id: 278, backdropPath: "/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg",
      title: "The Shawshank Redemption", voteAverage:  8.708,
    ),
  ],
);
