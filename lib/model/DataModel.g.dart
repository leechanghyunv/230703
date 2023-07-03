// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DataModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SubwayModel _$$_SubwayModelFromJson(Map<String, dynamic> json) =>
    _$_SubwayModel(
      subname: json['subname'] as String,
      engname: json['engname'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      line_ui: json['line_ui'] as String,
      subwayid: json['subwayid'] as int,
      line: json['line'] as String,
      heading: json['heading'] as String,
      isSelected: json['isSelected'] as bool? ?? false,
      km: json['km'] as num? ?? 0.0,
    );

Map<String, dynamic> _$$_SubwayModelToJson(_$_SubwayModel instance) =>
    <String, dynamic>{
      'subname': instance.subname,
      'engname': instance.engname,
      'lat': instance.lat,
      'lng': instance.lng,
      'line_ui': instance.line_ui,
      'subwayid': instance.subwayid,
      'line': instance.line,
      'heading': instance.heading,
      'isSelected': instance.isSelected,
      'km': instance.km,
    };
