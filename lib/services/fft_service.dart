
import 'package:fft/fft.dart';
import 'package:flutter_audio_visual/global/config.dart';
import 'package:flutter_audio_visual/model/signal.dart';
import 'package:flutter_audio_visual/services/util.dart';

class FftService {

  final _fft = FFT();

  Signal transform(Signal micSignal) {
    final fft = _fft.Transform(_prepareSamplesLengthForFft(micSignal));
    final freqSignal = fft.map((sample) => sample!.real.toInt()).toList();
    return Util.smoothSignal(freqSignal, Config.samplesToSmoothFreqSignal);
  }

  List<double> _prepareSamplesLengthForFft(Signal samples) {
    return samples.getRange(0, 1024).map((e) => e.toDouble()).toList();
    // int initialPowerOfTwo = (log(samples.length) * log2e).ceil();
    // int samplesFinalLength = pow(2, initialPowerOfTwo).toInt();
    // const samplesFinalLength = 2048;
    // final padding = List<double>.filled(samplesFinalLength - samples.length, 0.0);
    // final s = samples.map((sample) => sample.toDouble());
    // return [...s, ...padding];
  }

}