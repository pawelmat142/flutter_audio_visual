import 'dart:async';
import 'dart:typed_data';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_audio_visual/global/config.dart';
import 'package:flutter_audio_visual/model/signal.dart';
import 'package:flutter_audio_visual/services/fft_service.dart';
import 'package:flutter_audio_visual/services/get_it.dart';
import 'package:flutter_audio_visual/services/util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mic_stream/mic_stream.dart';

class SignalState {

  final bool running;
  final List<FlSpot> timeSpots;
  final List<FlSpot> frequencySpots;

  SignalState(
    this.running,
    this.timeSpots,
    this.frequencySpots,
  );

  SignalState copyWith({
    bool? running,
    List<FlSpot>? timeSpots,
    List<FlSpot>? frequencySpots,
  }) {
    return SignalState(
      running ?? this.running,
      timeSpots ?? this.timeSpots,
      frequencySpots ?? this.frequencySpots,
    );
  }

}

class SignalCubit extends Cubit<SignalState> {
  SignalCubit() : super(SignalState(
    false,
    [],
    []
  ));

  Stream<Uint8List>? _stream;
  StreamSubscription<Iterable<double>>? _subscription;

  final _fftService = getIt.get<FftService>();

  Signal micSignal = [];
  Signal freqSignal = [];

  start() {
    print('START!');
    if (_subscription?.isPaused ?? false) {
      _subscription?.resume();
    } else {
      _stream ??= MicStream.microphone(
        sampleRate: Config.sampleRate,
        audioSource: AudioSource.MIC,
        audioFormat: AudioFormat.ENCODING_PCM_8BIT,
        channelConfig: ChannelConfig.CHANNEL_IN_MONO
      );
      _subscription ??= _stream
          ?.map((Uint8List uint8list) => uint8list
            .where((sample) => sample > 30)
            .map((sample) => sample.toDouble()).toList())
          // ?.map((Uint8List uint8list) => uint8list.getRange(4, uint8list.length-4).toList())
          .listen(_micListener, onError: _onMicError, onDone: _onDone);
          // ?.listen(_micListener, onError: _onMicError, onDone: _onDone);
    }
    emit(state.copyWith(
      running: true,
    ));
  }

  stop() {
    print('STOP!');
    _subscription?.pause();
    emit(state.copyWith(
      running: false,
    ));
    before = null;
  }

  int? before;

  _micListener(List<double> samples) async {
    before = DateTime.now().microsecondsSinceEpoch;

    micSignal = Util.smoothSignal(samples, Config.samplesToSmoothMicSignal);
    freqSignal = _fftService.transform(micSignal);

    emit(state.copyWith(
      timeSpots: timeChartSpots,
      frequencySpots: freqChartSpots
    ));
  }


  List<FlSpot> get timeChartSpots {
    final smoothedSignal = Util.smoothSignal(micSignal, Config.samplesToSmoothTimeChart);
    return List<FlSpot>.generate(smoothedSignal.length, (x) {
      final y = smoothedSignal[x];
      return FlSpot(x * Config.deltaTime.toDouble(), y.toDouble());
    });
  }

  List<FlSpot> get freqChartSpots {
    final smoothedSignal = Util.smoothSignal(freqSignal, Config.samplesToSmoothFreqChart);
    final deltaFrequency = Config.sampleRate / smoothedSignal.length;
    const endOffset = 500;
    const startOffset = 10;
    return List<FlSpot>.generate(smoothedSignal.length ~/2, (f) {
      final double y = smoothedSignal[f].abs();
      return FlSpot(f * deltaFrequency, y);
    }).getRange(startOffset, endOffset).toList();
  }

  _onMicError(error) {
    print('ERROR');
    print(error);
  }

  _onDone() {
    print('DONE!!');
  }

  resetStream() async {
    await _subscription?.cancel();
    _subscription = null;
    _stream = null;
    emit(state.copyWith(
      timeSpots: [],
      frequencySpots: [],
      running: false,
    ));
  }

}