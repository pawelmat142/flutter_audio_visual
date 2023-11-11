import 'package:flutter/material.dart';
import 'package:flutter_audio_visual/global/extension.dart';
import 'package:flutter_audio_visual/model/signal_state.dart';
import 'package:flutter_audio_visual/presentation/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';

void main() {

  runApp(MultiBlocProvider(

    providers: [
      BlocProvider<SignalCubit>(create: (_) => SignalCubit())
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
        HomeScreen.id: (context) => const HomeScreen()
      },
    );
  }
}