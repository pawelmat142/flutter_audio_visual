import 'package:flutter_audio_visual/model/charts_setup.dart';
import 'package:hive_flutter/adapters.dart';

abstract class AppHive {

  static initBoxes() async {

    await Hive.initFlutter();

    Hive.registerAdapter(ChartsSetupAdapter());

    await ChartsSetup.openBox();
  }
}