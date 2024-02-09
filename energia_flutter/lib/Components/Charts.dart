// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample extends StatelessWidget {
  const LineChartSample({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<
        List<Map<String, dynamic>>>(
      future: _fetchData(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          ); // Show loading indicator while data is being fetched
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final List<Map<String, dynamic>> data =
              snapshot.data!;

          return Center(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              width: MediaQuery.of(context)
                      .size
                      .width *
                  0.9, // Adjust the width as needed
              height: MediaQuery.of(context)
                      .size
                      .height *
                  0.4, // Adjust the height as needed
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    horizontalInterval: 1,
                    verticalInterval: 1,
                    getDrawingHorizontalLine:
                        (value) {
                      return const FlLine(
                        color: Colors.amberAccent,
                        strokeWidth: 1,
                      );
                    },
                    getDrawingVerticalLine:
                        (value) {
                      return const FlLine(
                        color: Colors.greenAccent,
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(
                          showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(
                          showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1,
                        getTitlesWidget:
                            bottomTitleWidgets,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget:
                            leftTitleWidgets,
                        reservedSize: 42,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                        color: const Color(
                            0xff37434d)),
                  ),
                  minX: 0,
                  maxX: 12,
                  minY: 0,
                  maxY: 15,
                  lineBarsData: [
                    LineChartBarData(
                      spots: data
                          .map((entry) => FlSpot(
                              entry['date']
                                  .toDouble(),
                              entry['data']))
                          .toList(),
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 4,
                      isStrokeCapRound: true,
                      belowBarData: BarAreaData(
                        show: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget bottomTitleWidgets(
      double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('FEB', style: style);
        break;
      case 5:
        text = const Text('MAY', style: style);
        break;
      case 8:
        text = const Text('AUG', style: style);
        break;
      case 11:
        text = const Text('NOV', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(
      double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = (value.toInt()).toString();
        break;
      case 3:
        text = (value.toInt()).toString();
        break;
      case 5:
        text = (value.toInt()).toString();
        break;
      case 7:
        text = (value.toInt()).toString();
        break;
      case 9:
        text = (value.toInt()).toString();
        break;
      case 11:
        text = (value.toInt()).toString();
        break;
      case 13:
        text = (value.toInt()).toString();
        break;
      case 15:
        text = (value.toInt()).toString();
        break;
      default:
        return Container();
    }

    return Text(text,
        style: style, textAlign: TextAlign.left);
  }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Line Chart Example'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: LineChart(
//           LineChartData(
//             gridData: FlGridData(show: false),
//             titlesData: FlTitlesData(show: false),
//             borderData: FlBorderData(show: true),
//             lineBarsData: [
//               LineChartBarData(
//                 spots: data
//                     .map((entry) =>
//                     FlSpot(entry['date'].toDouble(), entry['data']))
//                     .toList(),
//                 isCurved: true,
//                 color: Colors.blue,
//                 barWidth: 4,
//                 isStrokeCapRound: true,
//                 belowBarData: BarAreaData(show: false),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// class LineChartSample extends StatefulWidget {
//   const LineChartSample({super.key});
//
//   @override
//   State<LineChartSample> createState() =>
//       _LineChartSampleState();
// }
//
// class _LineChartSampleState
//     extends State<LineChartSample> {
//   List<Color> gradientColors = [
//     Colors.cyan,
//     Colors.amber,
//   ];
//
//   bool showAvg = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         AspectRatio(
//           aspectRatio: 1.70,
//           child: Padding(
//             padding: const EdgeInsets.only(
//               right: 18,
//               left: 12,
//               top: 24,
//               bottom: 12,
//             ),
//             child: LineChart(
//               showAvg ? avgData() : mainData(),
//             ),
//           ),
//         ),
//         SizedBox(
//           width: 60,
//           height: 34,
//           child: TextButton(
//             onPressed: () {
//               setState(() {
//                 showAvg = !showAvg;
//               });
//             },
//             child: Text(
//               'avg',
//               style: TextStyle(
//                 fontSize: 12,
//                 color: showAvg
//                     ? Colors.black
//                         .withOpacity(0.5)
//                     : Colors.black,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget bottomTitleWidgets(
//       double value, TitleMeta meta) {
//     const style = TextStyle(
//       fontWeight: FontWeight.bold,
//       fontSize: 16,
//     );
//     Widget text;
//     switch (value.toInt()) {
//       case 2:
//         text = const Text('MAR', style: style);
//         break;
//       case 5:
//         text = const Text('JUN', style: style);
//         break;
//       case 8:
//         text = const Text('SEP', style: style);
//         break;
//       default:
//         text = const Text('', style: style);
//         break;
//     }
//
//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       child: text,
//     );
//   }
//
//   Widget leftTitleWidgets(
//       double value, TitleMeta meta) {
//     const style = TextStyle(
//       fontWeight: FontWeight.bold,
//       fontSize: 15,
//     );
//     String text;
//     switch (value.toInt()) {
//       case 1:
//         text = '10K';
//         break;
//       case 3:
//         text = '30k';
//         break;
//       case 5:
//         text = '50k';
//         break;
//       default:
//         return Container();
//     }
//
//     return Text(text,
//         style: style, textAlign: TextAlign.left);
//   }
//
//   LineChartData mainData() {
//     return LineChartData(
//       gridData: FlGridData(
//         show: true,
//         drawVerticalLine: true,
//         horizontalInterval: 1,
//         verticalInterval: 1,
//         getDrawingHorizontalLine: (value) {
//           return const FlLine(
//             color: Colors.greenAccent,
//             strokeWidth: 1,
//           );
//         },
//         getDrawingVerticalLine: (value) {
//           return const FlLine(
//             color: Colors.amberAccent,
//             strokeWidth: 1,
//           );
//         },
//       ),
//       titlesData: FlTitlesData(
//         show: true,
//         rightTitles: const AxisTitles(
//           sideTitles:
//               SideTitles(showTitles: false),
//         ),
//         topTitles: const AxisTitles(
//           sideTitles:
//               SideTitles(showTitles: false),
//         ),
//         bottomTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             reservedSize: 30,
//             interval: 1,
//             getTitlesWidget: bottomTitleWidgets,
//           ),
//         ),
//         leftTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             interval: 1,
//             getTitlesWidget: leftTitleWidgets,
//             reservedSize: 42,
//           ),
//         ),
//       ),
//       borderData: FlBorderData(
//         show: true,
//         border: Border.all(
//             color: const Color(0xff37434d)),
//       ),
//       minX: 0,
//       maxX: 11,
//       minY: 0,
//       maxY: 6,
//       lineBarsData: [
//         LineChartBarData(
//           spots: const [
//             FlSpot(0, 3),
//             FlSpot(2.6, 2),
//             FlSpot(4.9, 5),
//             FlSpot(6.8, 3.1),
//             FlSpot(8, 4),
//             FlSpot(9.5, 3),
//             FlSpot(11, 4),
//           ],
//           isCurved: true,
//           gradient: LinearGradient(
//             colors: gradientColors,
//           ),
//           barWidth: 5,
//           isStrokeCapRound: true,
//           dotData: const FlDotData(
//             show: false,
//           ),
//           belowBarData: BarAreaData(
//             show: true,
//             gradient: LinearGradient(
//               colors: gradientColors
//                   .map((color) =>
//                       color.withOpacity(0.3))
//                   .toList(),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   LineChartData avgData() {
//     return LineChartData(
//       lineTouchData:
//           const LineTouchData(enabled: false),
//       gridData: FlGridData(
//         show: true,
//         drawHorizontalLine: true,
//         verticalInterval: 1,
//         horizontalInterval: 1,
//         getDrawingVerticalLine: (value) {
//           return const FlLine(
//             color: Color(0xff37434d),
//             strokeWidth: 1,
//           );
//         },
//         getDrawingHorizontalLine: (value) {
//           return const FlLine(
//             color: Color(0xff37434d),
//             strokeWidth: 1,
//           );
//         },
//       ),
//       titlesData: FlTitlesData(
//         show: true,
//         bottomTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             reservedSize: 30,
//             getTitlesWidget: bottomTitleWidgets,
//             interval: 1,
//           ),
//         ),
//         leftTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             getTitlesWidget: leftTitleWidgets,
//             reservedSize: 42,
//             interval: 1,
//           ),
//         ),
//         topTitles: const AxisTitles(
//           sideTitles:
//               SideTitles(showTitles: false),
//         ),
//         rightTitles: const AxisTitles(
//           sideTitles:
//               SideTitles(showTitles: false),
//         ),
//       ),
//       borderData: FlBorderData(
//         show: true,
//         border: Border.all(
//             color: const Color(0xff37434d)),
//       ),
//       minX: 0,
//       maxX: 11,
//       minY: 0,
//       maxY: 6,
//       lineBarsData: [
//         LineChartBarData(
//           spots: const [
//             FlSpot(0, 3.44),
//             FlSpot(2.6, 3.44),
//             FlSpot(4.9, 3.44),
//             FlSpot(6.8, 3.44),
//             FlSpot(8, 3.44),
//             FlSpot(9.5, 3.44),
//             FlSpot(11, 3.44),
//           ],
//           isCurved: true,
//           gradient: LinearGradient(
//             colors: [
//               ColorTween(
//                       begin: gradientColors[0],
//                       end: gradientColors[1])
//                   .lerp(0.2)!,
//               ColorTween(
//                       begin: gradientColors[0],
//                       end: gradientColors[1])
//                   .lerp(0.2)!,
//             ],
//           ),
//           barWidth: 5,
//           isStrokeCapRound: true,
//           dotData: const FlDotData(
//             show: false,
//           ),
//           belowBarData: BarAreaData(
//             show: true,
//             gradient: LinearGradient(
//               colors: [
//                 ColorTween(
//                         begin: gradientColors[0],
//                         end: gradientColors[1])
//                     .lerp(0.2)!
//                     .withOpacity(0.1),
//                 ColorTween(
//                         begin: gradientColors[0],
//                         end: gradientColors[1])
//                     .lerp(0.2)!
//                     .withOpacity(0.1),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

  Future<List<Map<String, dynamic>>> _fetchData(
      BuildContext context) async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:5000/appliances/device_1'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData =
          json.decode(response.body);
      return jsonData
          .map((data) =>
              Map<String, dynamic>.from(data))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}