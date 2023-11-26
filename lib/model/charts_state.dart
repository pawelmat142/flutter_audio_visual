import 'package:flutter_audio_visual/model/chart_setting.dart';
import 'package:flutter_audio_visual/model/charts_setup.dart';
import 'package:flutter_audio_visual/services/get_it.dart';
import 'package:flutter_audio_visual/services/signal_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChartsState {

  final bool running;
  final List<ChartSetting> charts;
  final String setupId;

  ChartsState(
    this.running,
    this.charts,
    this.setupId,
  );

  ChartsState copyWith({
    bool? running,
    List<ChartSetting>? charts,
    String? setupId,
  }) {
    return ChartsState(
      running ?? this.running,
      charts ?? this.charts,
      setupId ?? this.setupId,
    );
  }

}

class ChartsCubit extends Cubit<ChartsState> {
  ChartsCubit() : super(ChartsState(
    false,
    [ChartSetting.defaultTime, ChartSetting.defaultFreq],
    '',
  ));

  final _signalService = getIt.get<SignalService>();

  start() {
    _signalService.startSignal();
    emit(state.copyWith(
      running: true,
    ));
  }

  stop() {
    _signalService.stopSignal();
    emit(state.copyWith(
      running: false,
    ));
  }

  reset() async {
    _signalService.resetSignal();
    emit(state.copyWith(
      running: false,
    ));
  }

  emitSetting({ required ChartSetting setting, required num value, required String field }) {
    final index = state.charts.indexOf(setting);
    if (index == -1) throw 'index == -1';
    final chart = state.charts[index];
    final newChart = chart.set(field: field, value: value);
    state.charts[index] = newChart;
    emit(state.copyWith( charts: state.charts ));
  }

  removeChart(ChartSetting setting) {
    final index = state.charts.indexOf(setting);
    if (index == -1) throw 'index == -1';
    final chart = state.charts[index];
    state.charts.remove(chart);
    emit(state.copyWith(
        charts: state.charts
    ));
  }

  addChart(ChartType type) {
    final chart = ChartSetting.getDefault(type);
    state.charts.add(chart);
    emit(state.copyWith(
      charts: state.charts
    ));
  }

  cleanSetupId() {
    emit(state.copyWith(
      setupId: '',
    ));
  }

  saveSetup() {
    final charts = state.charts;
    final setup = state.setupId.isNotEmpty
        ? ChartsSetup.override(charts, id: state.setupId)
        : ChartsSetup.create(charts);

    return setup.save();
  }

  loadSetup(ChartsSetup setup) {
    final charts = setup.chartSettings
        .map((settingJson) => ChartSetting.fromJson(settingJson))
        .toList();
    emit(state.copyWith(
      charts: charts,
      setupId: setup.id,
    ));
  }

}