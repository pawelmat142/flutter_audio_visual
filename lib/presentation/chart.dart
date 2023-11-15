import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AppChart extends StatelessWidget {

  final List<FlSpot> spots;
  final double height;
  final String? xLabel;
  final double? interval;
  final double? maxY;
  final double baseY;
  final GetTitleWidgetFunction? getTitleWidgetFunction;

  const AppChart(this.spots, {
    this.height = 300,
    this.xLabel,
    this.interval,
    this.maxY,
    this.baseY = 0,
    this.getTitleWidgetFunction,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: LineChart(
        LineChartData(
          baselineY: baseY,
          minY: 0,
          maxY: maxY,
          minX: 0,

          gridData: const FlGridData(
            show: true,
            drawVerticalLine: true,
            drawHorizontalLine: false,
          ),

          extraLinesData: ExtraLinesData(
            horizontalLines: [
              HorizontalLine(y: baseY,
                color: Colors.blueGrey.shade500,
                strokeWidth: .3
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
              axisNameWidget: xLabel == null ? null : Text(xLabel!, style: const TextStyle(color: Colors.blueAccent)),
              sideTitles: getTitleWidgetFunction == null ? SideTitles(
                interval: interval,
                showTitles: true,
              ) : SideTitles(
                interval: interval,
                getTitlesWidget: getTitleWidgetFunction!,
                showTitles: true,
              ),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
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
}
