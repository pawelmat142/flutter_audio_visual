import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_audio_visual/global/config.dart';
import 'package:flutter_audio_visual/model/signal.dart';
import 'package:flutter_audio_visual/services/fft_service.dart';
import 'package:flutter_audio_visual/services/get_it.dart';
import 'package:flutter_audio_visual/services/util.dart';
import 'package:mic_stream/mic_stream.dart';

class SignalService {

  final _fftService = getIt.get<FftService>();

  Stream<Uint8List>? _stream;
  StreamSubscription<Iterable<double>>? _subscription;

  Signal micSignal = [];
  Signal freqSignal = [];

  startMicrophoneListener() {
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
  }

  pauseMicrophoneListener() {
    _subscription?.pause();
  }

  resetMicrophoneListener() async {
    await _subscription?.cancel();
    _subscription = null;
    _stream = null;
  }

  int? before;

  _micListener(List<double> samples) async {
    before = DateTime.now().microsecondsSinceEpoch;
    micSignal = Util.smoothSignal(samples, Config.samplesToSmoothMicSignal);
    freqSignal = _fftService.transform(micSignal);
  }

  _onMicError(error) {
    print('ERROR');
    print(error);
  }

  _onDone() {
    print('DONE!!');
  }

}