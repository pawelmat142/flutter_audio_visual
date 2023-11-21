import 'package:flutter/material.dart';
import 'package:flutter_audio_visual/global/app_style.dart';
import 'package:flutter_audio_visual/global/config.dart';
import 'package:flutter_audio_visual/services/util.dart';

enum ChartType {
  time,
  frequency
}


class ChartSetting {

  final String name;
  final String unit;
  final ChartType type;

  final double minX;
  final double maxX;
  final double interval;

  final double minY;
  final double maxY;
  final double baseY;

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

  List<Widget> tilesList(BuildContext context) {
    return [
      ListTile(
        title: const Text('minX', style: AppStyle.smallWhite80,),
        trailing: Text(Util.valueDisplay(minX), style: AppStyle.secondaryMedium),
      ),
      ListTile(
        title: const Text('maxX', style: AppStyle.smallWhite80),
        trailing: Text(Util.valueDisplay(maxX), style: AppStyle.secondaryMedium),
      ),
      ListTile(
        title: const Text('minY', style: AppStyle.smallWhite80),
        trailing: Text(Util.valueDisplay(minY), style: AppStyle.secondaryMedium),
      ),
      ListTile(
        title: const Text('maxY', style: AppStyle.smallWhite80),
        trailing: Text(Util.valueDisplay(maxY), style: AppStyle.secondaryMedium),
      ),
      ListTile(
        title: const Text('minX', style: AppStyle.smallWhite80),
        trailing: Text(Util.valueDisplay(minX), style: AppStyle.secondaryMedium),
      ),
      ListTile(
        title: const Text('baseY', style: AppStyle.smallWhite80),
        trailing: Text(Util.valueDisplay(baseY), style: AppStyle.secondaryMedium),
      ),
      ListTile(
        title: const Text('samplesToSmooth', style: AppStyle.smallWhite80),
        trailing: Text(Util.valueDisplay(samplesToSmooth), style: AppStyle.secondaryMedium),
      ),
    ];
  }

}