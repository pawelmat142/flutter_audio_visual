import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_audio_visual/global/config.dart';
import 'package:flutter_audio_visual/model/chart_setting.dart';
import 'package:flutter_audio_visual/model/signal.dart';
import 'package:flutter_audio_visual/services/get_it.dart';
import 'package:flutter_audio_visual/services/signal_service.dart';
import 'package:flutter_audio_visual/services/util.dart';
import 'package:rxdart/transformers.dart';

class ChartService {

  final signalService = getIt.get<SignalService>();

  Stream<List<FlSpot>> spots$(ChartSetting setting) => _chartSignal$(setting)
      .throttleTime(const Duration(milliseconds: 10), trailing: true)
      .map((signal) => Util.smoothSignal(signal, setting.samplesToSmooth))
      .map((signal) => signalToSpots(signal, setting));


  Stream<Isignal> _chartSignal$(ChartSetting setting) {
    if (setting.type == ChartType.time) {
      return signalService.micSignal$;
    }
    if (setting.type == ChartType.frequency) {
      return signalService.freqSignal$;
    }
    throw 'unknown ChartType';
  }


  List<FlSpot> signalToSpots(Signal signal, ChartSetting setting) {
    if (setting.type == ChartType.time) {
      return timeSpots(signal);
    }
    if (setting.type == ChartType.frequency) {
      return freqSpots(signal);
    }
    throw 'unknown ChartType';
  }

  List<FlSpot> timeSpots(Signal signal) {
    return List<FlSpot>.generate(signal.length, (x) {
      final y = signal[x];
      return FlSpot(x * Config.deltaTime.toDouble(), y.toDouble());
    });
  }

  List<FlSpot> freqSpots(Signal signal) {
    final deltaFrequency = Config.sampleRate / signal.length;
    return List<FlSpot>.generate(signal.length ~/2, (f) {
      final int y = signal[f].abs();
      return FlSpot(f * deltaFrequency, y.toDouble());
    })
        .getRange(1, signal.length)
        .toList();
  }
}