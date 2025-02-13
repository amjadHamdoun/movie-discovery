import 'package:fh/features/movie_details/data/models/production_company_model.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/movie_details_entity.dart';
import 'genres_model.dart';

part 'movie_details_model.g.dart';

@JsonSerializable()
class MovieDetailsModel extends MovieDetailsEntity {
  final int id;
  final String? title;

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @JsonKey(name: 'vote_average', defaultValue: 0.0)
  final double voteAverage;

  @JsonKey(name: 'genres', defaultValue: [])
  final List<GenresModel> genres;

  @JsonKey(name: 'production_companies', defaultValue: [])
  final List<ProductionCompanyModel> productionCompanies;

  @JsonKey(name: 'release_date', fromJson: _fromJson, toJson: _toJson)
  final DateTime releaseDate;

  final String? overview;

  MovieDetailsModel({
    required this.id,
    required this.title,
    required this.backdropPath,
    required this.voteAverage,
    required this.genres,
    required this.productionCompanies,
    required this.releaseDate,
    required this.overview,
  }) : super(
    image: backdropPath , // Ensure non-null value
    rate: voteAverage,
    movieId: id,
    movieTitle: title ?? "Unknown Title",
    movieGenres: genres,
    movieOverview: overview ?? "No overview available.",
    movieReleaseDate: releaseDate,
    movieProductionCompanies: productionCompanies,
  );

  factory MovieDetailsModel.fromJson(Map<String, dynamic> data) =>
      _$MovieDetailsModelFromJson(data);

  Map<String, dynamic> toJson() => _$MovieDetailsModelToJson(this);

  // DateTime Converters
  static DateTime _fromJson(String? date) =>
      date != null ? DateTime.tryParse(date) ?? DateTime(2000) : DateTime(2000);

  static String _toJson(DateTime date) => date.toIso8601String();
}
