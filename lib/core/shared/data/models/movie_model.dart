
import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

import '../../domin/entities/movie_entity.dart';
part 'movie_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class MovieModel extends MovieEntity {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  @JsonKey(name: 'backdrop_path')
   final String? backdropPath;
  @HiveField(3)
  @JsonKey(name: 'vote_average',defaultValue: 0.0)
  final double voteAverage;


  MovieModel(
      {
        required this.backdropPath,
        required this.voteAverage,
        required this.title,
        required this.id
   }):super(
    image: backdropPath,
    rate: voteAverage,
    movieId: id,
    movieTitle: title
  );

  factory MovieModel.fromJson(
      final Map<String, dynamic> data) =>
      _$MovieModelFromJson(data);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);

  static List<MovieModel> fromJsonList(List? json) {
    return json?.map((e) => MovieModel.fromJson(e)).toList() ?? [];
  }



@override
bool operator ==(Object other) =>
    identical(this, other) ||
    other is MovieModel && runtimeType == other.runtimeType && movieId == other.movieId;

@override
int get hashCode => movieId.hashCode;

}
