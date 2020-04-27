import 'package:flutter/material.dart';
import 'package:Covid/dailogBox.dart';
// import 'imageBox.dart';
// import 'cov.dart';
import 'package:Covid/textData.dart';

class Statelist extends StatelessWidget {
  // const Statelist({Key key}) : super(key: key);
  final List indiaCountrydata;
  final BuildContext context;
  final int index;
  Statelist(this.context, this.indiaCountrydata, this.index);
  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      
      return new GestureDetector(
        onTap: () => showDialog(
              context: context,
              builder: (context) => DailogBox(context, indiaCountrydata[index]),
            ),
        child: Container(
        child: Column(
          children: <Widget>[
            AnimatedContainer(
              curve: Curves.easeIn,
              duration: Duration(seconds: 1),
              padding: EdgeInsets.all(14),
              margin: EdgeInsets.all(4),
              child: Text("India",
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
                    TextData("New Confirmed",
                        int.parse(indiaCountrydata[index]['deltaconfirmed'])),
                    TextData("New Deaths",
                        int.parse(indiaCountrydata[index]['deltadeaths'])),
                    TextData("New Recovered",
                        int.parse(indiaCountrydata[index]['deltarecovered'])),
                  ]),
                  color: Colors.transparent,
                  // width: MediaQuery.of(context).size.width,
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  child: Column(children: [
                    TextData("Total Confirmed",
                        int.parse(indiaCountrydata[index]['confirmed'])),
                    TextData("Total Deaths",
                        int.parse(indiaCountrydata[index]['deaths'])),
                    TextData("Total Recovered",
                        int.parse(indiaCountrydata[index]['recovered'])),
                  ]),
                  // color: Color.fromRGBO(0, 0, 0, 0),
                  // width: MediaQuery.of(context).size.width,
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(3, 2, 3, 2),
                child: Text(
                  "Last updated on : "+
                  indiaCountrydata[index]['lastupdatedtime'],
                  style: TextStyle(color: Colors.black38, fontSize: 12),
                ),
              ),
          ],
        ),
      ),
      );
    }
    return new GestureDetector(
         onTap: () => showDialog(
              context: context,
              builder: (context) => DailogBox(context, indiaCountrydata[index]),
            ),
        child: Container(
          // key: Key(indiaCountrydata[index]),
          padding: const EdgeInsets.all(4.0),
          margin: EdgeInsets.all(4),
          child: new ExpansionTile(
            title: Text(
              indiaCountrydata[index]['state'].toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w300),
              // style: Theme.of(context).textTheme.title,
            ),
            children: <Widget>[
              Divider(
                thickness: 1.0,
                color: Colors.black54,
                indent: 25.0,
                endIndent: 25.0,
              ),
              SizedBox(height: 4.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    // margin: EdgeInsets.only(left: 16.0),
                    padding: const EdgeInsets.all(4),
                    child: Column(children: [
                      TextData("New Confirmed",
                          int.parse(indiaCountrydata[index]['deltaconfirmed'])),
                      TextData("New Deaths",
                          int.parse(indiaCountrydata[index]['deltadeaths'])),
                      TextData("New Recovered",
                          int.parse(indiaCountrydata[index]['deltarecovered'])),
                    ]),
                    color: Colors.transparent,
                    // width: MediaQuery.of(context).size.width,
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    child: Column(children: [
                      TextData("Total Confirmed",
                          int.parse(indiaCountrydata[index]['confirmed'])),
                      TextData("Total Deaths",
                          int.parse(indiaCountrydata[index]['deaths'])),
                      TextData("Total Recovered",
                          int.parse(indiaCountrydata[index]['recovered'])),
                    ]),
                    // color: Color.fromRGBO(0, 0, 0, 0),
                    // width: MediaQuery.of(context).size.width,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
