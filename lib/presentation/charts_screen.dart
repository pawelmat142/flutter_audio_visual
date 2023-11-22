import 'package:flutter/material.dart';
import 'package:flutter_audio_visual/global/app_style.dart';
import 'package:flutter_audio_visual/model/chart_setting.dart';
import 'package:flutter_audio_visual/model/charts_state.dart';
import 'package:flutter_audio_visual/presentation/app_chart.dart';
import 'package:flutter_audio_visual/presentation/dialog/app_snackbar.dart';
import 'package:flutter_audio_visual/presentation/home.dart';
import 'package:flutter_audio_visual/presentation/setups_screen.dart';
import 'package:flutter_audio_visual/services/extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChartsScreen extends StatelessWidget {

  static const String id = 'charts_screen';
  const ChartsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ChartsCubit>(context);

    return BlocBuilder<ChartsCubit, ChartsState>(builder: (ctx, state) {
      return WillPopScope(
        onWillPop: () {
          cubit.cleanSetupId();
          return Future(() => true);
        },
        child: Scaffold(
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
            IconButton(
              icon:  const Icon(Icons.add,
                color: AppColor.secondary,
              ),
              onPressed: () => selectTypeDialog(context, cubit)
            ),
            IconButton(
                icon:  const Icon(Icons.save,
                  color: AppColor.secondary,
                ),
                onPressed: () {
                  cubit.saveSetup().then((_) {
                    AppSnackBar.show(context: context, text: 'saved!');
                    Navi.popUntilNamed(context, HomeScreen.id);
                    Navigator.pushNamed(context, SetupsScreen.id);
                  });
                },
            ),
          ]),

          body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final containerHeight = constraints.maxHeight;
              final charts = state.charts.length;

              final height = charts < 3 ? containerHeight / 2 : containerHeight / charts;
              return ListView(
                padding: AppStyle.defaultPadding,
                children: state.charts.map((setting) => AppChart(
                  height: height,
                  setting: setting)).toList(),
              );
            }
          ),

        ),
      );
    });

  }

  selectTypeDialog(BuildContext context, ChartsCubit cubit) {
    showDialog(context: context, builder: (ctx) {
      return AlertDialog(
        actionsAlignment: MainAxisAlignment.spaceBetween,
        title: const Text('select type'),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(ctx);
          }, child: const Text('Cancel')),
          TextButton(onPressed: () {
            Navigator.pop(ctx, ChartType.time);
          }, child: const Text('TIME')),
          TextButton(onPressed: () {
            Navigator.pop(ctx, ChartType.frequency);
          }, child: const Text('FREQ')),
        ],
      );
    }).then((type) {
      if (type is ChartType) {
        cubit.addChart(type);
      }
    });
  }

}
