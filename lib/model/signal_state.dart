import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mic_stream/mic_stream.dart';
import 'package:fft/fft.dart';

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
  static const int sampleRate = 44000;
  static const double deltaTime = 1/sampleRate;

  Stream<Uint8List>? _stream;
  StreamSubscription<Iterable<double>>? _subscription;

  start() {
    print('START!');
    if (_subscription?.isPaused ?? false) {
      _subscription?.resume();
    } else {
      _stream ??= MicStream.microphone(
        sampleRate: sampleRate,
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

    final timeSpots = List<FlSpot>.generate(samples.length, (x) {
      final y = samples[x];
      return FlSpot(x * deltaTime.toDouble(), y.toDouble());
    });

    final fftSamples = _prepareFftSignal(samples);

    final deltaFrequency = sampleRate / fftSamples.length;
    // print(fftSamples);

    const startOffset = 10;
    const endOffset = 500;

    final frequencySpots = List<FlSpot>.generate(fftSamples.length ~/2, (f) {
      final double y = fftSamples[f]!.abs();
      return FlSpot(f * deltaFrequency, y);
    }).getRange(startOffset, endOffset).toList();

    emit(state.copyWith(
      timeSpots: timeSpots,
      frequencySpots: frequencySpots
    ));
  }

  _prepareFftSignal(List<double> s) {
    final samples = prepareSamplesLengthForFft(s);
    var fft = FFT().Transform(samples).map((sample) => sample!.real).toList();
    return _smoothSignal(fft);
  }

  List<double> _smoothSignal(List<double> signal) {
    const samplesToSmooth = 5;
    List<double> result = [];
    for (var i = samplesToSmooth-1; i < signal.length; i++) {
      result.add(signal.getRange(i-samplesToSmooth+1, i-1).reduce((a, b) => a+b)/samplesToSmooth);
    }
    return result;
  }

  List<double> prepareSamplesLengthForFft(List<double> samples) {
    int initialPowerOfTwo = (log(samples.length) * log2e).ceil();
    int samplesFinalLength = pow(2, initialPowerOfTwo).toInt();
    final padding = List<double>.filled(samplesFinalLength - samples.length, 0.toDouble());
    return [...samples, ...padding];
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