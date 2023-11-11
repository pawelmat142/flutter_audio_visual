import 'package:flutter/material.dart';
import 'package:flutter_audio_visual/model/signal_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final cubit = BlocProvider.of<SignalCubit>(context);

    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          ElevatedButton(child: const Text('start'),
            onPressed: () {
              cubit.start();
            },
          ),

          ElevatedButton(child: const Text('stop'),
            onPressed: () {
              cubit.stop();
            },
          )
        ],
      ),

    );
  }
}
