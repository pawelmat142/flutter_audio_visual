import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_visual/model/charts_state.dart';

class FrequencyChart extends StatelessWidget {

  final ChartsState state;

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
            maxX: 2000,
            lineBarsData: [
              LineChartBarData(
                spots: state.frequencySpots,
                dotData: const FlDotData(show: false),
              ),
            ],

            borderData: FlBorderData(
              show: false,
            ),

            gridData: const FlGridData(
              show: true,
              drawVerticalLine: true,
              drawHorizontalLine: false,
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
                axisNameWidget: const Text('Frequency [Hz]', style: TextStyle(color: Colors.blueAccent)),
                sideTitles: SideTitles(
                  interval: 200,
                  showTitles: true,
                  getTitlesWidget: getMyTitle,
                ),
              ),
            ),
          ),


        )
    );
  }

  Widget getMyTitle(double value, TitleMeta meta) {
    String title = '';
    if (value >= 1000) {
      title = '${(value / 1000).toString().split('.0').first}k';
      // title = '${value / 1000}k';
    } else if (value > 100) {
      title = value.toInt().toString();
    }
    return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(title)
    );
  }

}
