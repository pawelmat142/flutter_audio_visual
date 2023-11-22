import 'package:flutter_audio_visual/global/config.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chart_setting.g.dart';

enum ChartType {
  time,
  frequency
}
// flutter packages pub run build_runner build --delete-conflicting-outputs


@JsonSerializable()
class ChartSetting {

  final String name;
  final String unit;
  final ChartType type;

  double minX;
  double maxX;
  double interval;

  double minY;
  double maxY;
  double baseY;

  final int samplesToSmooth;

  ChartSetting({
    required this.name,
    required this.unit,
    required this.type,
    required this.minX,
    required this.maxX,
    required this.interval,
    required this.minY,
    required this.maxY,
    required this.baseY,
    required this.samplesToSmooth,
  });

  static ChartSetting get defaultTime => ChartSetting(
      name: 'Time',
      unit: '[µs]',
      type: ChartType.time,
      minX: 0,
      maxX: 0.03,
      interval: .3,
      minY: 0,
      maxY: 255,
      baseY: 127,
      samplesToSmooth: Config.samplesToSmoothTimeChart,
  );

  static ChartSetting get defaultFreq => ChartSetting(
    name: 'Frequency',
    unit: '[Hz]',
    type: ChartType.frequency,
    minX: Config.chartMinFreq,
    maxX: Config.chartMaxFreq,
    interval: 200,
    minY: 0,
    maxY: 2000,
    baseY: 0,
    samplesToSmooth: Config.samplesToSmoothFreqChart,
  );

  static ChartSetting fromJson(Map<String, dynamic> json) {
    return _$ChartSettingFromJson(json);
  }

  Map<String, dynamic> get toJson => _$ChartSettingToJson(this);

  ChartSetting set({required String field, required dynamic value}) {
    final json = toJson;
    final currentValue = json[field];
    if (currentValue.runtimeType != value.runtimeType) {
      if (currentValue is double && value is int) {
        value = value.toDouble();
      } else {
        throw 'input type: ${value.runtimeType}, current type: ${currentValue.runtimeType}, name: $field';
      }
    }
    json[field] = value;
    return fromJson(json);
  }

  dynamic get({required String field}) {
    return toJson[field];
  }

}