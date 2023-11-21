import 'dart:async';

import 'package:flutter_audio_visual/global/config.dart';
import 'package:flutter_audio_visual/model/signal.dart';
import 'package:flutter_audio_visual/services/fft_service.dart';
import 'package:flutter_audio_visual/services/get_it.dart';
import 'package:mic_stream/mic_stream.dart';

class SignalService {

  Stream<Signal> get micSignal$ => _micSignalController.stream;
  Stream<Signal> get freqSignal$ => _micSignalController.stream
      .map(_fftService.transform);

  final _fftService = getIt.get<FftService>();

  final _micSignalController = StreamController<Signal>.broadcast();

  StreamSubscription<Signal>? _micSubscription$;

  Stream<Signal> get _micStream$ => MicStream.microphone(
      sampleRate: Config.sampleRate,
      audioSource: AudioSource.MIC,
      audioFormat: AudioFormat.ENCODING_PCM_8BIT,
      channelConfig: ChannelConfig.CHANNEL_IN_MONO
  );


  startSignal() {
    if (_micSubscription$?.isPaused ?? false) {
      _micSubscription$?.resume();
    } else {
      _micSubscription$ ??= _micStream$.listen(
        _micSignalController.sink.add,
        onDone: () => print('ondone'),
        onError: (error) => print(error)
      );
    }
  }

  stopSignal() {
    _micSubscription$?.pause();
  }

  resetSignal() async {
    await _micSubscription$?.cancel();
    _micSubscription$ = null;
  }

}