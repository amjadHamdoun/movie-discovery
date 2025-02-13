
import 'package:fh/features/movie_details/domain/entities/production_company_entity.dart';

import 'genres_entity.dart';

class MovieDetailsEntity {
  final int movieId;
  final String? image;
  final String? movieTitle;
  final double rate;
  final List<GenresEntity> movieGenres;
  final List<ProductionCompanyEntity> movieProductionCompanies;

  final String? movieOverview;
  final DateTime movieReleaseDate;

  MovieDetailsEntity({
    required this.movieId,
    required this.movieTitle,
    required this.rate,
    required this.image,
    required this.movieGenres,
    required this.movieOverview,
    required this.movieReleaseDate,
    required this.movieProductionCompanies

  });
}
