import 'package:flutter/material.dart';
import 'package:flutter_audio_visual/model/charts_state.dart';
import 'package:flutter_audio_visual/presentation/charts_screen.dart';
import 'package:flutter_audio_visual/presentation/setups_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final cubit = BlocProvider.of<ChartsCubit>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {
              cubit.cleanSetupId();
              Navigator.pushNamed(context, ChartsScreen.id);
            }, child: const Text('charts')),

            ElevatedButton(onPressed: () {
              Navigator.pushNamed(context, SetupsScreen.id);
            }, child: const Text('setups')),

          ],
        ),
      )
    );
  }
}
