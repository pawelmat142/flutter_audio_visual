import 'dart:async';
import 'dart:typed_data';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mic_stream/mic_stream.dart';

class SignalState {

  final bool running;
  final List<FlSpot> timeSpots;

  SignalState(
    this.running,
    this.timeSpots,
  );

  SignalState copyWith({
    bool? running,
    List<FlSpot>? timeSpots,
  }) {
    return SignalState(
      running ?? this.running,
      timeSpots ?? this.timeSpots,
    );
  }

}

class SignalCubit extends Cubit<SignalState> {
  SignalCubit() : super(SignalState(
    false,
    []
  ));
  static const int sampleRate = 22000;
  static const double deltaTime = 1/sampleRate;

  Stream<Uint8List>? _stream;
  StreamSubscription<Iterable<int>>? _subscription;

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
          ?.map((Uint8List uint8list) => uint8list.getRange(4, uint8list.length-4).toList())
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

  _micListener(List<int> samples) async {
    before = DateTime.now().microsecondsSinceEpoch;
    print(samples);

    // final deltaTime = 1E6 / (sampleRate * samples.length);
    final timeSpots = List<FlSpot>.generate(samples.length, (x) {
      final y = samples[x];
      return FlSpot(x * deltaTime.toDouble(), y.toDouble());
    });

    emit(state.copyWith(
      timeSpots: timeSpots
    ));

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
      running: false,
    ));
  }

}