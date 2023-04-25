import 'package:json_annotation/json_annotation.dart';

part 'cricket_data_model.g.dart';

@JsonSerializable()
class CricketDataModel {
  @JsonKey(name: 'player_name')
  final String? playerName;
  @JsonKey(name: 'team_name')
  final String? teamName;
  @JsonKey(name: 'position')
  final int? position;
  @JsonKey(name: 'points')
  final int? points;
  @JsonKey(name: 'rating')
  final int? rating;
  @JsonKey(name: 'match_type')
  final int? matchType;
  @JsonKey(name: 'status')
  final int? status;
  @JsonKey(name: 'team')
  final String? team;

  CricketDataModel({
    this.playerName,
    this.matchType,
    this.points,
    this.position,
    this.rating,
    this.status,
    this.teamName,
    this.team,
  });

  factory CricketDataModel.fromJson(Map<String, dynamic> json) =>
      _$CricketDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$CricketDataModelToJson(this);
}
