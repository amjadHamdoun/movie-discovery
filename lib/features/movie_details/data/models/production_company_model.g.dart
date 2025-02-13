// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'production_company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductionCompanyModel _$ProductionCompanyModelFromJson(
        Map<String, dynamic> json) =>
    ProductionCompanyModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      logo: json['logo'] as String?,
      country: json['country'] as String?,
    );

Map<String, dynamic> _$ProductionCompanyModelToJson(
        ProductionCompanyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'country': instance.country,
    };
