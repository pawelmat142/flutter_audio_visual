// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChartSetting _$ChartSettingFromJson(Map<String, dynamic> json) => ChartSetting(
      name: json['name'] as String,
      unit: json['unit'] as String,
      type: $enumDecode(_$ChartTypeEnumMap, json['type']),
      strokeWidth: (json['strokeWidth'] as num).toDouble(),
      strokeColor: json['strokeColor'] as int,
      strokeSmoothness: (json['strokeSmoothness'] as num).toDouble(),
      minX: (json['minX'] as num).toDouble(),
      maxX: (json['maxX'] as num).toDouble(),
      interval: (json['interval'] as num?)?.toDouble(),
      minY: (json['minY'] as num?)?.toDouble(),
      maxY: (json['maxY'] as num?)?.toDouble(),
      baseY: (json['baseY'] as num?)?.toDouble(),
      samplesToSmooth: json['samplesToSmooth'] as int,
    );

Map<String, dynamic> _$ChartSettingToJson(ChartSetting instance) =>
    <String, dynamic>{
      'name': instance.name,
      'unit': instance.unit,
      'type': _$ChartTypeEnumMap[instance.type]!,
      'strokeWidth': instance.strokeWidth,
      'strokeColor': instance.strokeColor,
      'strokeSmoothness': instance.strokeSmoothness,
      'minX': instance.minX,
      'maxX': instance.maxX,
      'interval': instance.interval,
      'minY': instance.minY,
      'maxY': instance.maxY,
      'baseY': instance.baseY,
      'samplesToSmooth': instance.samplesToSmooth,
    };

const _$ChartTypeEnumMap = {
  ChartType.time: 'time',
  ChartType.frequency: 'frequency',
};
