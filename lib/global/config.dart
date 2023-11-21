abstract class Config {

  ///
  /// Signal sampling frequency
  ///
  static const int sampleRate = 44000;  //[Hz]
  /// Sometimes its easier to use [μs] than [Hz]
  static const double deltaTime = 1/sampleRate; //[μs]

  ///
  /// makes signal smoother but costs precision
  /// samplesToSmooth cannot be less than 2.
  /// 2 - makes error.
  /// 1, 0 - no smooth (input=output).
  ///
  static const int samplesToSmoothMicSignal = 1;
  static const int samplesToSmoothFreqSignal = 1;
  ///
  /// Those are used only for charts rendering
  ///
  static const int samplesToSmoothTimeChart = 1;
  static const int samplesToSmoothFreqChart = 20;

  ///
  /// this parameter destiny is to decrease charts rendering frequency
  /// value has been determined empirically through a series of experiments
  static const int chartsRefreshRate = 10;  //[Hz]

  ///
  /// frequency signal chart widget: X axis limits
  static const double chartMaxFreq = 1500; // [Hz]
  static const double chartMinFreq = 10;  // [Hz]

}