import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_visual/model/chart_setting.dart';
import 'package:flutter_audio_visual/services/chart_service.dart';
import 'package:flutter_audio_visual/services/get_it.dart';

class AppChart extends StatelessWidget {

  final ChartSetting setting;

  final double height;

  const AppChart({
    required this.setting,
    this.height = 300,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final chartService = getIt.get<ChartService>();

    return SizedBox(
      height: height,
      child: StreamBuilder(

        stream: chartService.spots$(setting),

        builder: (BuildContext ctx, AsyncSnapshot<List<FlSpot>> snapshot) {

          final spots = snapshot.data ?? [];
          return LineChart(
            LineChartData(
              baselineY: setting.baseY.toDouble(),
              minY: setting.minY.toDouble(),
              maxY: setting.maxY.toDouble(),
              minX: setting.minX.toDouble(),
              maxX: setting.maxX.toDouble(),

              gridData: const FlGridData(
                show: true,
                drawVerticalLine: true,
                drawHorizontalLine: false,
              ),

              extraLinesData: ExtraLinesData(
                horizontalLines: [
                  HorizontalLine(y: setting.baseY.toDouble(),
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
                  axisNameWidget: Text('${setting.name} ${setting.unit}', style: const TextStyle(color: Colors.blueAccent)),
                  sideTitles: SideTitles(
                    interval: setting.interval,
                    getTitlesWidget: getMyTitle,
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
          );
        }
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