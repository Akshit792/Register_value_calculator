// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColorDataModel _$ColorDataModelFromJson(Map<String, dynamic> json) =>
    ColorDataModel(
      colorData: json['color'] as String,
      colorName: json['color_name'] as String,
      digit1: json['first_digit'] as int?,
      digit2: json['second_digit'] as int?,
      multiplier: (json['multiplier'] as num?)?.toDouble(),
      tolerance: json['tolerance'] as String?,
    );

Map<String, dynamic> _$ColorDataModelToJson(ColorDataModel instance) =>
    <String, dynamic>{
      'color': instance.colorData,
      'color_name': instance.colorName,
      'first_digit': instance.digit1,
      'second_digit': instance.digit2,
      'multiplier': instance.multiplier,
      'tolerance': instance.tolerance,
    };
