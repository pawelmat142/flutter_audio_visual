abstract class Util {

  static List<double> smoothSignal(List<double> signal, int samplesToSmooth) {
    if (samplesToSmooth < 2) {
      return signal;
    }
    List<double> result = [];
    for (var i = samplesToSmooth-1; i < signal.length; i++) {
      result.add(signal.getRange(i-samplesToSmooth+1, i-1).reduce((a, b) => a+b)/samplesToSmooth);
    }
    return result;
  }

}