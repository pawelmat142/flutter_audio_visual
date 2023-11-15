import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_audio_visual/global/config.dart';
import 'package:flutter_audio_visual/services/get_it.dart';
import 'package:flutter_audio_visual/services/signal_service.dart';
import 'package:flutter_audio_visual/services/util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChartsState {

  final bool running;
  final List<FlSpot> timeSpots;
  final List<FlSpot> frequencySpots;

  ChartsState(
    this.running,
    this.timeSpots,
    this.frequencySpots,
  );

  ChartsState copyWith({
    bool? running,
    List<FlSpot>? timeSpots,
    List<FlSpot>? frequencySpots,
  }) {
    return ChartsState(
      running ?? this.running,
      timeSpots ?? this.timeSpots,
      frequencySpots ?? this.frequencySpots,
    );
  }

}

class ChartsCubit extends Cubit<ChartsState> {
  ChartsCubit() : super(ChartsState(
    false,
    [],
    []
  ));

  final _signalService = getIt.get<SignalService>();

  Timer? _chartsRefreshTimer;

  start() {
    _signalService.startMicrophoneListener();
    emit(state.copyWith(
      running: true,
    ));
    _startChartsRefresher();
  }

  stop() {
    _signalService.pauseMicrophoneListener();
    _stopChartsRefresher();
    emit(state.copyWith(
      running: false,
    ));
  }

  reset() async {
    _stopChartsRefresher();
    _signalService.resetMicrophoneListener();
    emit(state.copyWith(
      timeSpots: [],
      frequencySpots: [],
      running: false,
    ));
  }

  _startChartsRefresher() {
    const duration = Duration(milliseconds: 1000 ~/ Config.chartsRefreshRate);
    _chartsRefreshTimer = Timer.periodic(duration, _refreshCharts);
  }

  _stopChartsRefresher() {
    _chartsRefreshTimer?.cancel();
    _chartsRefreshTimer = null;
  }

  _refreshCharts(Timer _) {
    emit(state.copyWith(
        timeSpots: timeChartSpots,
        frequencySpots: freqChartSpots
    ));
  }

  List<FlSpot> get timeChartSpots {
    final smoothedSignal = Util.smoothSignal(_signalService.micSignal, Config.samplesToSmoothTimeChart);
    return List<FlSpot>.generate(smoothedSignal.length, (x) {
      final y = smoothedSignal[x];
      return FlSpot(x * Config.deltaTime.toDouble(), y.toDouble());
    });
  }

  List<FlSpot> get freqChartSpots {
    final smoothedSignal = Util.smoothSignal(_signalService.freqSignal, Config.samplesToSmoothFreqChart);
    final deltaFrequency = Config.sampleRate / smoothedSignal.length;
    const endOffset = 500;
    const startOffset = 10;
    if (smoothedSignal.length < endOffset) {
      return [];
    }
    return List<FlSpot>.generate(smoothedSignal.length ~/2, (f) {
      final double y = smoothedSignal[f].abs();
      return FlSpot(f * deltaFrequency, y);
    }).getRange(startOffset, endOffset).toList();
  }

}