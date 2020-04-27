import 'package:Covid/textData.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'indicator.dart';

class PieChartSample2 extends StatefulWidget {
  final Map inData;
  final BuildContext context;

  PieChartSample2(
    this.context,
    this.inData,
  );

  // {
  //   print('testtst');
  //   print(countryData);
  // }
  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex;
  // get countryData => null;

  @override
  Widget build(BuildContext context) {
    var deathPer = 0;
    var recoveredPer = 0;
    var stillConfPer = 0;
    if (widget.inData['TotalDeaths'] != null) {
      if (widget.inData['TotalDeaths'] == 0 ||
          widget.inData['TotalConfirmed'] == 0 ||
          widget.inData['TotalRecovered'] == 0) {
            // print("zero");
            return TextData('Cases Currently',0);
      } else {
      deathPer =
          ((widget.inData['TotalDeaths'] / widget.inData['TotalConfirmed']) *
                  100)
              .round();
      recoveredPer =
          ((widget.inData['TotalRecovered'] / widget.inData['TotalConfirmed']) *
                  100)
              .round();
      stillConfPer = 100 - (deathPer + recoveredPer);
      }
    }
    if (widget.inData['state'] != null) {
      if (widget.inData['deaths'] == '0' ||
          widget.inData['confirmed'] == '0' ||
          widget.inData['confirmed'] == '0') {
            // print("zero");
            return TextData('Cases Currently',0);
      } else {
        deathPer = ((int.parse(widget.inData['deaths']) /
                    int.parse(widget.inData['confirmed'])) *
                100)
            .round();
        recoveredPer = ((int.parse(widget.inData['recovered']) /
                    int.parse(widget.inData['confirmed'])) *
                100)
            .round();
        stillConfPer = 100 - (deathPer + recoveredPer);
      }
    }

    return AspectRatio(
      aspectRatio: 1.5,
      child: Card(
        color: Colors.white,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 0,
        child: Row(
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData:
                          PieTouchData(touchCallback: (pieTouchResponse) {
                        setState(() {
                          if (pieTouchResponse.touchInput is FlLongPressEnd ||
                              pieTouchResponse.touchInput is FlPanEnd) {
                            touchedIndex = -1;
                          } else {
                            touchedIndex = pieTouchResponse.touchedSectionIndex;
                          }
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 2,
                      centerSpaceRadius: 35,
                      sections: showingSections(
                          deathPer, recoveredPer, stillConfPer)),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Indicator(
                  color: Colors.red,
                  text: 'Deaths',
                  isSquare: false,
                ),
                SizedBox(
                  height: 2,
                ),
                Indicator(
                  color: Colors.green,
                  text: 'Recovered',
                  isSquare: false,
                ),
                SizedBox(
                  height: 2,
                ),
                Indicator(
                  color: Colors.blue,
                  text: 'Active',
                  isSquare: false,
                ),
                SizedBox(
                  height: 2,
                ),
                // Indicator(
                //   color: Color(0xff13d38e),
                //   text: 'Fourth',
                //   isSquare: true,
                // ),
                SizedBox(
                  height: 18,
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(
      deathPer, recoveredPer, stillConfPer) {
    // print('countryData');
    // print(countryData);
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 45 : 40;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.red,
            value: deathPer.toDouble(),
            title: deathPer.toString() + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.green,
            value: recoveredPer.toDouble(), // countryData['TotalConfirmed'],
            title: recoveredPer.toString() +
                '%', // countryData['TotalConfirmed'].toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.blue,
            value: stillConfPer.toDouble(),
            title: stillConfPer.toString() + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        // case 3:
        //   return PieChartSectionData(
        //     color: const Color(0xff13d38e),
        //     value: 15,
        //     title: '15%',
        //     radius: radius,
        //     titleStyle: TextStyle(
        //         fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
        //   );
        default:
          return null;
      }
    });
  }
}
