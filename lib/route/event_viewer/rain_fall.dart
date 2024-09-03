import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AdvancedWeatherChart extends StatefulWidget {
  const AdvancedWeatherChart({super.key});

  @override
  State<AdvancedWeatherChart> createState() => _AdvancedWeatherChartState();
}

class _AdvancedWeatherChartState extends State<AdvancedWeatherChart> {
  String selectedDataType = 'temperature';
  int touchedIndex = -1;

  final Map<String, List<double>> weatherData = {
    'temperature': [22, 23, 25, 24, 23, -99, 21, 20, 19, 18, 17, 16, 15, 16, 18, 20, 22, 24, 25, 26, 25, 24, 23, 22],
    'wind_speed': [5, 6, 7, 8, 7, 6, 5, 4, 3, 4, 5, 6, 7, 8, 9, 10, 9, 8, 7, 6, 5, 4, 3, 4],
    'precipitation': [
      0,
      0.5,
      1.2,
      0.8,
      0.3,
      0,
      0,
      0,
      0.1,
      0.4,
      0.2,
      0,
      0,
      0,
      0.1,
      0.3,
      0.5,
      0.7,
      0.4,
      0.2,
      0.1,
      0,
      0,
      0
    ],
    'humidity': [65, 67, 70, 72, 75, 73, 70, 68, 65, 63, 60, 58, 55, 53, 50, 52, 55, 58, 60, 63, 65, 68, 70, 72],
    'pressure': [
      1013,
      1012,
      1011,
      1010,
      1009,
      1010,
      1011,
      1012,
      1013,
      1014,
      1015,
      1016,
      1017,
      1016,
      1015,
      1014,
      1013,
      1012,
      1011,
      1010,
      1009,
      1010,
      1011,
      1012
    ],
  };

  final List<double> windDirection = [
    0,
    45,
    90,
    135,
    180,
    225,
    270,
    315,
    0,
    45,
    90,
    135,
    180,
    225,
    270,
    315,
    0,
    45,
    90,
    135,
    180,
    225,
    270,
    315
  ];

  final Map<String, String> dataTypeToChineseMap = {
    'temperature': '溫度',
    'wind_speed': '風速',
    'precipitation': '降水',
    'humidity': '濕度',
    'pressure': '氣壓',
  };

  final Map<String, String> units = {
    'temperature': '°C',
    'wind_speed': 'm/s',
    'precipitation': 'mm',
    'humidity': '%',
    'pressure': 'hPa',
  };

  Color getDataTypeColor(String dataType) {
    switch (dataType) {
      case 'temperature':
        return Colors.red;
      case 'wind_speed':
        return Colors.orange;
      case 'precipitation':
        return Colors.blue;
      case 'humidity':
        return Colors.purple;
      case 'pressure':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('天氣趨勢圖'),
        actions: [_buildDataTypeSelector()],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildChart(),
              const SizedBox(height: 24),
              _buildLegend(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    String displayValue = touchedIndex != -1
        ? '$touchedIndex時: ${weatherData[selectedDataType]![touchedIndex]}${units[selectedDataType]}'
        : '24小時平均: ${_calculate24HourAverage()}${units[selectedDataType]}';

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '24小時${dataTypeToChineseMap[selectedDataType]}趨勢',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                if (selectedDataType == 'wind_speed')
                  Transform.rotate(
                    angle: (windDirection[touchedIndex != -1 ? touchedIndex : 0] + 180) % 360,
                    child: Icon(Icons.arrow_upward, color: getDataTypeColor(selectedDataType)),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              displayValue,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: getDataTypeColor(selectedDataType),
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  String _calculate24HourAverage() {
    List<double> validData = weatherData[selectedDataType]!.where((value) => value != -99).toList();
    if (validData.isEmpty) return 'N/A';
    double sum = validData.reduce((a, b) => a + b);
    return (sum / validData.length).toStringAsFixed(1);
  }

  Widget _buildChart() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: selectedDataType == 'precipitation' ? _buildBarChart() : _buildLineChart(),
        ),
      ),
    );
  }

  Widget _buildLineChart() {
    Color lineColor = getDataTypeColor(selectedDataType);
    List<FlSpot> spots = [];
    for (int i = 0; i < weatherData[selectedDataType]!.length; i++) {
      if (weatherData[selectedDataType]![i] == -99) {
        spots.add(FlSpot.nullSpot);
      } else {
        spots.add(FlSpot(i.toDouble(), weatherData[selectedDataType]![i]));
      }
    }

    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) => Text('${value.toInt()}時'),
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) => Text(value.toInt().toString()),
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: lineColor,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: lineColor.withOpacity(0.3),
              gradient: LinearGradient(
                colors: [lineColor.withOpacity(0.3), lineColor.withOpacity(0.0)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          touchCallback: (FlTouchEvent event, LineTouchResponse? touchResponse) {
            setState(() {
              if (event is FlPanEndEvent || event is FlTapUpEvent || event is FlLongPressEnd) {
                touchedIndex = -1;
              } else if (touchResponse?.lineBarSpots != null && touchResponse!.lineBarSpots!.isNotEmpty) {
                touchedIndex = touchResponse.lineBarSpots![0].x.toInt();
              }
            });
          },
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return List.filled(touchedBarSpots.length, null);
            },
          ),
          getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
            return spotIndexes.map((spotIndex) {
              return TouchedSpotIndicatorData(
                const FlLine(
                  color: Colors.white,
                  strokeWidth: 2,
                  dashArray: [5, 5],
                ),
                FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 3,
                      color: Colors.white,
                      strokeWidth: 2,
                      strokeColor: Colors.grey,
                    );
                  },
                ),
              );
            }).toList();
          },
        ),
        extraLinesData: ExtraLinesData(
          horizontalLines: [
            HorizontalLine(
              y: double.parse(_calculate24HourAverage()),
              color: Colors.black45,
              strokeWidth: 1,
              dashArray: [5, 5],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    Color barColor = getDataTypeColor(selectedDataType);
    return BarChart(
      BarChartData(
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) => Text('${value.toInt()}時'),
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) => Text(value.toInt().toString()),
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: true),
        barGroups: weatherData['precipitation']!
            .asMap()
            .entries
            .map((entry) => BarChartGroupData(
                  x: entry.key,
                  barRods: [BarChartRodData(toY: entry.value, color: barColor)],
                ))
            .toList(),
        barTouchData: BarTouchData(
          touchCallback: (FlTouchEvent event, BarTouchResponse? touchResponse) {
            setState(() {
              if (event is FlPanEndEvent || event is FlTapUpEvent || event is FlLongPressEnd) {
                touchedIndex = -1;
              } else if (touchResponse?.spot != null) {
                touchedIndex = touchResponse!.spot!.touchedBarGroupIndex;
              }
            });
          },
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${rod.toY}${units['precipitation']}',
                const TextStyle(color: Colors.white),
              );
            },
          ),
        ),
        extraLinesData: ExtraLinesData(
          horizontalLines: [
            HorizontalLine(
              y: weatherData['precipitation']!.reduce((a, b) => a + b) / 24,
              color: Colors.black45,
              strokeWidth: 1,
              dashArray: [5, 5],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataTypeSelector() {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      initialValue: selectedDataType,
      onSelected: (String value) {
        setState(() {
          selectedDataType = value;
          touchedIndex = -1;
        });
      },
      itemBuilder: (BuildContext context) => weatherData.keys
          .map((String choice) => PopupMenuItem<String>(
                value: choice,
                child: Text(dataTypeToChineseMap[choice]!),
              ))
          .toList(),
    );
  }

  Widget _buildLegend() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('圖例', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 20,
                  height: 3,
                  color: getDataTypeColor(selectedDataType),
                ),
                const SizedBox(width: 8),
                Text(dataTypeToChineseMap[selectedDataType]!),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 20,
                  height: 1,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black45,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Text('24小時平均'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
