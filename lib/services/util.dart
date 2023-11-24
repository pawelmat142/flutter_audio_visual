import 'dart:typed_data';

import 'package:flutter_audio_visual/model/signal.dart';
import 'package:flutter_audio_visual/services/extension.dart';

abstract class Util {

  static Signal smoothSignal(Isignal signal, int samplesToSmooth) {
    if (samplesToSmooth < 2) {
      return signal.toList();
    }
    Signal result = [];
    for (var i = samplesToSmooth-1; i < signal.length; i++) {
      result.add(signal.toList().getRange(i-samplesToSmooth+1, i-1).reduce((a, b) => a+b)~/samplesToSmooth);
    }
    return result;
  }

  static Signal toSignal(Uint8List uint8list) {
    return List<int>.from(uint8list);
  }

  static Isignal filterZeros(Isignal signal) {
    return signal.where((sample) => sample > 2);
  }

  static String valueDisplay(num value) {
    if (value == 0) {
      return '0';
    } else if (value >= 1000000) {
      return '${(value/1000000).toStringAsFixed(2)} M';
    } else if (value >= 1000) {
      return '${(value/1000).toStringAsFixed(2)} k';
    } else if (value <= 0.0001) {
      return '${(value * 1000000).toStringAsFixed(2)} μ';
    } else if (value <= 0.1) {
      return '${(value*1000).toStringAsFixed(2)} m';
    } else {
      return value.toString().cutDotZero.cutAfterDot;
    }
  }

}