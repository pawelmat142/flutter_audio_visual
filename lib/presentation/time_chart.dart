// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_audio_visual/model/charts_state.dart';
// import 'package:flutter_audio_visual/presentation/chart.dart';
//
// class TimeChart extends StatelessWidget {
//
//   final ChartsState state;
//
//   const TimeChart(this.state, {
//     Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AppChart(state.timeSpots,
//       maxY: 255,
//       baseY: 127,
//       getTitleWidgetFunction: getMyTitle,
//       xLabel: 'Time [us]',
//       interval: .01,
//     );
//   }
//
//   Widget getMyTitle(double value, TitleMeta meta) {
//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       child: Text((value*1000).toInt().toString())
//     );
//   }
// }
