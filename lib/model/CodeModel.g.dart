// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CodeModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CodeModel _$$_CodeModelFromJson(Map<String, dynamic> json) => _$_CodeModel(
      stationCd: json['STATION_CD'] as String? ?? "정보없음",
      subwayname: json['STATION_NM'] as String? ?? "정보없음",
      line: json['LINE_NUM'] as String? ?? "정보없음",
      code: json['FR_CODE'] as String? ?? "정보없음",
    );

Map<String, dynamic> _$$_CodeModelToJson(_$_CodeModel instance) =>
    <String, dynamic>{
      'STATION_CD': instance.stationCd,
      'STATION_NM': instance.subwayname,
      'LINE_NUM': instance.line,
      'FR_CODE': instance.code,
    };
