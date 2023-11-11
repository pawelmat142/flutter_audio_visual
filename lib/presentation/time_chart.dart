import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_visual/model/signal_state.dart';

class TimeChart extends StatelessWidget {

  final SignalState state;

  const TimeChart(this.state, {
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: LineChart(
        LineChartData(
          baselineY: 128,
          minY: 0,
          maxY: 255,
          minX: 0,

          gridData: const FlGridData(
            show: true,
            drawVerticalLine: true,
            drawHorizontalLine: false,
          ),

          extraLinesData: ExtraLinesData(
            horizontalLines: [
              HorizontalLine(y: 128,
                color: Colors.blueGrey.shade500,
                strokeWidth: .5
              )
            ]
          ),

          borderData: FlBorderData(
            show: false,
          ),

          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)
            ),
            rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)
            ),
            leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)
            ),
            bottomTitles: AxisTitles(
              axisNameWidget: const Text('time [us]', style: TextStyle(color: Colors.blueAccent)),
              sideTitles: SideTitles(
                interval: 0.01,
                getTitlesWidget: getMyTitle,
                showTitles: true,
                // getTitlesWidget: (x, y) => Text('5'),
              ),
              axisNameSize: 20,

            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: state.timeSpots,
              barWidth: 2,
              dotData: const FlDotData(show: false),
              isStrokeCapRound: false,
              isStepLineChart: false,
              isStrokeJoinRound: false,
              preventCurveOvershootingThreshold: 0,
              curveSmoothness: 5,
            )
          ],
        ),
      ),
    );
  }

  Widget getMyTitle(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text((value*1000).toInt().toString())
    );
  }
}
