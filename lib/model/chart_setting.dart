import 'package:flutter_audio_visual/global/config.dart';

enum ChartType {
  time,
  frequency
}


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

}