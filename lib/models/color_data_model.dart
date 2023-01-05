import 'package:json_annotation/json_annotation.dart';

part 'color_data_model.g.dart';

@JsonSerializable()
class ColorDataModel {
  @JsonKey(name: 'color')
  final String colorData;
  @JsonKey(name: 'color_name')
  final String colorName;
  @JsonKey(name: 'first_digit')
  final int? digit1;
  @JsonKey(name: 'second_digit')
  final int? digit2;
  @JsonKey(name: 'multiplier')
  final double? multiplier;
  @JsonKey(name: 'tolerance')
  final String? tolerance;

  ColorDataModel({
    required this.colorData,
    required this.colorName,
    required this.digit1,
    required this.digit2,
    required this.multiplier,
    required this.tolerance,
  });

  factory ColorDataModel.fromJson(Map<String, dynamic> json) =>
      _$ColorDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ColorDataModelToJson(this);
}
