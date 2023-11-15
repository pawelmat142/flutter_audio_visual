import 'dart:math';

import 'package:fft/fft.dart';
import 'package:flutter_audio_visual/global/config.dart';
import 'package:flutter_audio_visual/model/signal.dart';
import 'package:flutter_audio_visual/services/util.dart';

class FftService {

  final _fft = FFT();

  Signal transform(Signal micSignal) {
    final samples = _prepareSamplesLengthForFft(micSignal);
    final freqSignal = _fft.Transform(samples).map((sample) => sample!.real).toList();
    return Util.smoothSignal(freqSignal, Config.samplesToSmoothFreqSignal);
  }

  Signal _prepareSamplesLengthForFft(Signal samples) {
    int initialPowerOfTwo = (log(samples.length) * log2e).ceil();
    int samplesFinalLength = pow(2, initialPowerOfTwo).toInt();
    final padding = List<double>.filled(samplesFinalLength - samples.length, 0.toDouble());
    return [...samples, ...padding];
  }

}