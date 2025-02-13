


import 'package:fh/features/movie_details/domain/entities/production_company_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'production_company_model.g.dart';

@JsonSerializable()
class ProductionCompanyModel extends ProductionCompanyEntity {
  ProductionCompanyModel({required super.id, required super.name, required super.logo, required super.country});

  factory ProductionCompanyModel.fromJson(Map<String, dynamic> data) =>
      _$ProductionCompanyModelFromJson(data);

  Map<String, dynamic> toJson() => _$ProductionCompanyModelToJson(this);
  
}
