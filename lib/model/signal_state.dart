import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mic_stream/mic_stream.dart';

class SignalState {

  final bool running;

  SignalState(
    this.running,
  );

  SignalState copyWith({
    bool? running
  }) {
    return SignalState(
      running ?? this.running
    );
  }

}

class SignalCubit extends Cubit<SignalState> {
  SignalCubit() : super(SignalState(
    false
  ));

  Stream<Uint8List>? _stream;
  StreamSubscription<Int16List>? _subscription;

  start() {
    if (_subscription?.isPaused ?? false) {
      _subscription?.resume();
    } else {
      _stream ??= MicStream.microphone(
          sampleRate: 44100,
          audioSource: AudioSource.MIC
      );
      _subscription ??= _stream?.transform(ppm16transformer).listen(_micListener);
    }
    emit(state.copyWith(
      running: true,
    ));
  }

  stop() {
    _subscription?.pause();
    emit(state.copyWith(
      running: false,
    ));
  }

  _micListener(Int16List sample) {
    print(sample);
  }

  final ppm16transformer = StreamTransformer<Uint8List, Int16List>.fromHandlers(handleData: (sample, sink) {
    sink.add(sample.buffer.asInt16List());
  });
}