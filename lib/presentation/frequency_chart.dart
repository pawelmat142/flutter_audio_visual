import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_visual/model/signal_state.dart';

class FrequencyChart extends StatelessWidget {

  final SignalState state;

  const FrequencyChart(this.state, {
    Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 300,
        child: LineChart(
          LineChartData(
            baselineY: 0,
            maxY: 2000,
            maxX: 5000,
            lineBarsData: [
              LineChartBarData(
                spots: state.frequencySpots,
                dotData: const FlDotData(show: false),
              ),
            ],

            titlesData: const FlTitlesData(
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false)
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false)
              ),
            ),
          ),


        )
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return AppChart(
  //     state.frequencySpots,
  //   );
  // }
}
