// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailsModel _$MovieDetailsModelFromJson(Map<String, dynamic> json) =>
    MovieDetailsModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      genres: (json['genres'] as List<dynamic>?)
              ?.map((e) => GenresModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      productionCompanies: (json['production_companies'] as List<dynamic>?)
              ?.map((e) =>
                  ProductionCompanyModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      releaseDate: MovieDetailsModel._fromJson(json['release_date'] as String?),
      overview: json['overview'] as String?,
    );

Map<String, dynamic> _$MovieDetailsModelToJson(MovieDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'backdrop_path': instance.backdropPath,
      'vote_average': instance.voteAverage,
      'genres': instance.genres,
      'production_companies': instance.productionCompanies,
      'release_date': MovieDetailsModel._toJson(instance.releaseDate),
      'overview': instance.overview,
    };
