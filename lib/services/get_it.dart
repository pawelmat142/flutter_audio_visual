import 'package:flutter_audio_visual/services/fft_service.dart';
import 'package:flutter_audio_visual/services/signal_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

abstract class AppGetIt {

  static void init() {

    getIt.registerSingleton<FftService>(FftService());
    getIt.registerSingleton<SignalService>(SignalService());

  }

}