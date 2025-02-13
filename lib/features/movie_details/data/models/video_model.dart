

import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/video_entity.dart';

part 'video_model.g.dart';

@JsonSerializable()
class VideoModel extends VideoEntity {
  VideoModel({required super.key, required super.name});


  factory VideoModel.fromJson(Map<String, dynamic> data) =>
      _$VideoModelFromJson(data);

  Map<String, dynamic> toJson() => _$VideoModelToJson(this);

  static List<VideoModel> fromJsonList(List? json) {
    return json?.map((e) => VideoModel.fromJson(e)).toList() ?? [];
  }


}
