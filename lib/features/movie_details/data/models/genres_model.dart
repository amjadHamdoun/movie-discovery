

import 'package:fh/features/movie_details/domain/entities/genres_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'genres_model.g.dart';

@JsonSerializable()
class GenresModel extends GenresEntity {
  GenresModel({required super.id, required super.name});


  factory GenresModel.fromJson(Map<String, dynamic> data) =>
      _$GenresModelFromJson(data);

  Map<String, dynamic> toJson() => _$GenresModelToJson(this);


}
