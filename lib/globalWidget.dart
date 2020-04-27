import 'package:flutter/material.dart';
import 'textData.dart';
import 'pieChart.dart';
class GlobalWidget extends StatelessWidget {
  // const GlobalWidget({Key key}) : super(key: key);
  final Map globalData;
  GlobalWidget(this.globalData);

  @override
  Widget build(BuildContext context) {
  return Column(
  
  children: <Widget>[
              // PieChartSample2(),
              //   Divider(thickness: 1.0, color: Colors.black54),
              //   // SizedBox(height: 4.0),
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       Container(
              //         // margin: EdgeInsets.only(left: 16.0),
              //         padding: const EdgeInsets.all(8),
              //         child: Column(children: [
              //           TextData( "NewConfirmed",
              //               globalData['NewConfirmed']),
              //           TextData( "NewDeaths",
              //               globalData['NewDeaths']),
              //           TextData("NewRecovered",
              //               globalData['NewRecovered']),
              //         ]),
              //         // color: Colors.blueAccent,
              //         // width: MediaQuery.of(context).size.width,
              //       ),
              //       Container(
              //         padding: const EdgeInsets.all(8),
              //         child: Column(children: [
              //           TextData( "TotalConfirmed",
              //               globalData['TotalConfirmed']),
              //           TextData( "TotalDeaths",
              //               globalData['TotalDeaths']),
              //           TextData("TotalRecovered",
              //               globalData['TotalRecovered']),
              //         ]),
              //         // color: Colors.redAccent,
              //         // width: MediaQuery.of(context).size.width,
              //       ),
              //     ],
              //   ),
              // 
              ],
  );
}
  
}