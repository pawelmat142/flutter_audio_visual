import 'package:flutter/material.dart';
import 'package:flutter_audio_visual/global/app_style.dart';
import 'package:flutter_audio_visual/model/charts_state.dart';
import 'package:flutter_audio_visual/presentation/app_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChartsScreen extends StatelessWidget {

  static const String id = 'charts_screen';
  const ChartsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ChartsCubit>(context);

    return BlocBuilder<ChartsCubit, ChartsState>(builder: (ctx, state) {
      return Scaffold(
        appBar: AppBar(actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              cubit.reset();
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
          IconButton(
            icon:  const Icon(Icons.settings,
              color: AppColor.secondary,
            ),
            onPressed: () {
              // SettingsModal.show(context, chartName: 'Time');
              // SettingsModal.show(context);
            },
          ),
        ]),

        body: ListView(
          padding: AppStyle.defaultPadding,
          children: state.charts.map((setting) => AppChart(setting: setting)).toList(),
        ),

      );
    });

  }

}
