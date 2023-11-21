import 'package:flutter/material.dart';
import 'package:flutter_audio_visual/presentation/charts_screen.dart';
import 'package:flutter_audio_visual/services/extension.dart';
import 'package:flutter_audio_visual/model/charts_state.dart';
import 'package:flutter_audio_visual/presentation/home.dart';
import 'package:flutter_audio_visual/services/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';

void main() {

  AppGetIt.init();

  runApp(MultiBlocProvider(

    providers: [
      BlocProvider<ChartsCubit>(create: (_) => ChartsCubit()),
    ],

    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Flutter Demo',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      navigatorKey: Navi.navigatorKey,
      navigatorObservers: [NavigationHistoryObserver()],

      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => const HomeScreen(),
        ChartsScreen.id: (context) => const ChartsScreen()
      },
    );
  }
}