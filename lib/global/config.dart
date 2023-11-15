abstract class Config {

  static const int sampleRate = 44000;  //[Hz]
  static const double deltaTime = 1/sampleRate;

  static const int samplesToSmoothMicSignal = 1;
  static const int samplesToSmoothFreqSignal = 5;

  static const int samplesToSmoothTimeChart = 1;
  static const int samplesToSmoothFreqChart = 1;

  static const int chartsRefreshRate = 10;  //[Hz]

  static const int chartMaxFreq = 5000;
  static const int chartMinFreq = 1;

}