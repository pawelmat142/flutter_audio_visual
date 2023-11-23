import 'package:flutter/material.dart';
import 'package:flutter_audio_visual/global/app_style.dart';
import 'package:flutter_audio_visual/model/charts_state.dart';
import 'package:flutter_audio_visual/presentation/app_chart.dart';
import 'package:flutter_audio_visual/presentation/charts_screen_toolbar.dart';
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

          bottomNavigationBar: const ChartsScreenToolbar(),

        ),
      );
    });

  }

}
