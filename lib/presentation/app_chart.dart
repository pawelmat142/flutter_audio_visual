import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_visual/global/app_style.dart';
import 'package:flutter_audio_visual/model/chart_setting.dart';
import 'package:flutter_audio_visual/model/charts_state.dart';
import 'package:flutter_audio_visual/presentation/dialog/setting_dialog.dart';
import 'package:flutter_audio_visual/services/chart_service.dart';
import 'package:flutter_audio_visual/services/extension.dart';
import 'package:flutter_audio_visual/services/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final cubit = BlocProvider.of<ChartsCubit>(context);

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

              lineTouchData: LineTouchData(
                enabled: false,
                touchCallback: (event, response) {
                  final index = cubit.state.charts.indexOf(setting);
                  if (index == -1) throw 'index = -1!';

                  showDialog(context: context, builder: (ctx) {
                    return SettingDialog(setting);
                  });
                }
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
                  axisNameWidget: Text('${setting.name} [${setting.unit}]', style: const TextStyle(color: Colors.blueAccent)),
                  sideTitles: SideTitles(
                    interval: setting.interval,
                    getTitlesWidget: xAxisLabel,
                    showTitles: true,
                  ),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  barWidth: setting.strokeWidth,
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


  Widget xAxisLabel(double value, TitleMeta meta) {
    String suffix = '';


    if (value != 0) {
      if (value >= 100) {
        value /= 1000;
        suffix = 'k';
      } else if (value >= 100000) {
        value /= 1000000;
        suffix = 'M';
      } else if (value <= 0.1) {
        value *= 1000;
        suffix = 'm';
      } else if (value <= 0.0001) {
        value *= 1000000;
      }
    }


    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        '${value.toString().cutAfterDot.cutDotZero.cutZeroDot}$suffix',
        style: AppStyle.xSmallPrimary
      )
    );
  }
}
