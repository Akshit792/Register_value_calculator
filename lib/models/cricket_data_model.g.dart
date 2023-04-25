// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cricket_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CricketDataModel _$CricketDataModelFromJson(Map<String, dynamic> json) =>
    CricketDataModel(
      playerName: json['player_name'] as String?,
      matchType: json['match_type'] as int?,
      points: json['points'] as int?,
      position: json['position'] as int?,
      rating: json['rating'] as int?,
      status: json['status'] as int?,
      teamName: json['team_name'] as String?,
      team: json['team'] as String?,
    );

Map<String, dynamic> _$CricketDataModelToJson(CricketDataModel instance) =>
    <String, dynamic>{
      'player_name': instance.playerName,
      'team_name': instance.teamName,
      'position': instance.position,
      'points': instance.points,
      'rating': instance.rating,
      'match_type': instance.matchType,
      'status': instance.status,
      'team': instance.team,
    };
