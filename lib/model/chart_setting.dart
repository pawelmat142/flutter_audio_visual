import 'package:flutter_audio_visual/global/app_style.dart';
import 'package:flutter_audio_visual/global/config.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chart_setting.g.dart';

enum ChartType {
  time,
  frequency
}
// flutter packages pub run build_runner build --delete-conflicting-outputs

//TODO full screen mode

@JsonSerializable()
class ChartSetting {

  final String name;
  final String unit;
  final ChartType type;

  double strokeWidth;
  int strokeColor;
  double strokeSmoothness;

  double minX;
  double maxX;
  double? interval;

  double? minY;
  double? maxY;
  double? baseY;

  final int samplesToSmooth;

  ChartSetting({
    required this.name,
    required this.unit,
    required this.type,
    required this.strokeWidth,
    required this.strokeColor,
    required this.strokeSmoothness,
    required this.minX,
    required this.maxX,
    this.interval,
    this.minY,
    this.maxY,
    this.baseY,
    required this.samplesToSmooth,
  });

  static ChartSetting get defaultTime => ChartSetting(
    name: 'Time',
    unit: 's',
    type: ChartType.time,
    strokeWidth: 1,
    strokeColor: AppColor.palette[1].value,
    strokeSmoothness: .5,
    minX: 0,
    maxX: 0.03,
    minY: 0,
    maxY: 255,
    baseY: 127,
    samplesToSmooth: Config.samplesToSmoothTimeChart,
  );

  static ChartSetting get defaultFreq => ChartSetting(
    name: 'Frequency',
    unit: 'Hz',
    type: ChartType.frequency,
    strokeWidth: 2,
    strokeColor: AppColor.palette[2].value,
    strokeSmoothness: 0,
    minX: 1,
    maxX: 2000,
    samplesToSmooth: Config.samplesToSmoothFreqChart,
  );

  static ChartSetting getDefault(ChartType type) {
    if (type == ChartType.time) {
      return defaultTime;
    }
    if (type == ChartType.frequency) {
      return defaultFreq;
    }
    throw 'unknown ChartType';
  }

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