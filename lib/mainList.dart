import 'package:flutter/material.dart';
import 'dailogBox.dart';
import 'imageBox.dart';
import 'textData.dart';


class MainList extends StatelessWidget {
  // const MainList({Key key}) : super(key: key);
  final List countryData;
  final BuildContext context;
  final int index;
  MainList(this.context,this.countryData,this.index);
  @override
  Widget build(BuildContext context) {
    String photoUrl = "icons/flags/png/2.5x/" +
        countryData[index]["CountryCode"].toLowerCase() +
        ".png";
    return new GestureDetector(
        onTap: () => showDialog(
              context: context,
              builder: (context) => DailogBox(context, countryData[index]),
            ),
        child: Padding(
          key: Key(countryData[index]['Country']),
          padding: const EdgeInsets.all(8.0),
          child: new ExpansionTile(
              // backgroundColor: Colors.purple[300],
              // initiallyExpanded:opentile?true:false,
              leading: Imagebox(photoUrl: photoUrl,),
              title: Text(
                countryData[index]['Country'].toString(),
                style: Theme.of(context).textTheme.title,
              ),
              children: <Widget>[
                Divider(thickness: 1.0, color: Colors.black54,indent: 30.0,endIndent: 30.0,),
                // SizedBox(height: 4.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      // margin: EdgeInsets.only(left: 16.0),
                      padding: const EdgeInsets.all(8),
                      child: Column(children: [
                        TextData( "NewConfirmed",
                            countryData[index]['NewConfirmed']),
                        TextData( "NewDeaths",
                            countryData[index]['NewDeaths']),
                        TextData( "NewRecovered",
                            countryData[index]['NewRecovered']),
                      ]),
                      // color: Colors.blueAccent,
                      // width: MediaQuery.of(context).size.width,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(children: [
                        TextData( "TotalConfirmed",
                            countryData[index]['TotalConfirmed']),
                        TextData( "TotalDeaths",
                            countryData[index]['TotalDeaths']),
                        TextData( "TotalRecovered",
                            countryData[index]['TotalRecovered']),
                      ]),
                      // color: Colors.redAccent,
                      // width: MediaQuery.of(context).size.width,
                    ),
                  ],
                ),
              ]),
        ));
  }
}