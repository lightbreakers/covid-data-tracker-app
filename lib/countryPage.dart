import 'package:flutter/material.dart';
import 'dailogBox.dart';
import 'textData.dart';
import './mainList.dart';
// import 'snackBar.dart';

class CountryPage extends StatelessWidget {
  // const name({Key key}) : super(key: key);
  final int index;
  final List countryData;
  final Map globalData;
  final String dateData;
  CountryPage(this.index, this.countryData, this.globalData, this.dateData);

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return new GestureDetector(
        onTap: () => showDialog(
              context: context,
              builder: (context) => DailogBox(context, globalData),
            ),
        child: Container(
        child: Column(
          children: <Widget>[
            AnimatedContainer(
              curve: Curves.easeIn,
              duration: Duration(seconds: 1),
              padding: EdgeInsets.all(14),
              margin: EdgeInsets.all(4),
              child: Text("Worldwide",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 36,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w300)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  // margin: EdgeInsets.only(left: 16.0),
                  padding: const EdgeInsets.all(4),
                  child: Column(children: [
                    TextData("New Confirmed", globalData['NewConfirmed']),
                    TextData("New Deaths", globalData['NewDeaths']),
                    TextData("New Recovered", globalData['NewRecovered']),
                  ]),
                  color: Colors.transparent,
                  // width: MediaQuery.of(context).size.width,
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  child: Column(children: [
                    TextData("Total Confirmed", globalData['TotalConfirmed']),
                    TextData("Total Deaths", globalData['TotalDeaths']),
                    TextData("Total Recovered", globalData['TotalRecovered']),
                  ]),
                  // color: Color.fromRGBO(0, 0, 0, 0),
                  // width: MediaQuery.of(context).size.width,
                ),
              ],
            ),
            // SnackBarPage(),
            Padding(
                padding: const EdgeInsets.fromLTRB(3, 2, 3, 2),
                child: Text(
                  "Last updated on : "+
                  dateData,
                  style: TextStyle(color: Colors.black38, fontSize: 12),
                ),
              ),
          ],
        ),
      ),
      );
    }
    return MainList(context, countryData, index);
  }
}
