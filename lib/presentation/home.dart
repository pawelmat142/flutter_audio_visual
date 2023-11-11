import 'package:flutter/material.dart';
import 'package:flutter_audio_visual/model/signal_state.dart';
import 'package:flutter_audio_visual/presentation/time_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final cubit = BlocProvider.of<SignalCubit>(context);

    return BlocBuilder<SignalCubit, SignalState>(
      builder: (cts, state) {
        return Scaffold(

        appBar: AppBar(actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              cubit.resetStream();
            },
          ),
          IconButton(
            icon:  Icon(state.running ? Icons.stop_circle : Icons.play_circle,
              color: state.running ? Colors.redAccent : Colors.blueAccent,
            ),
            onPressed: () {
              state.running ? cubit.stop() : cubit.start();
            },
          ),
        ],),

        body: ListView(
          padding: const EdgeInsets.all(15),
          children: [

            TimeChart(state),
          ],
        ),
      );
      },
    );

  }
}
