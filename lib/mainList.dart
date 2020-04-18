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
        child: Container(
          key: Key(countryData[index]['Country']),

          // color: Colors.red,
          padding: const EdgeInsets.all(4.0),
          margin: EdgeInsets.all(4),
          // decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.circular(25),
          //       border: Border.all(
          //         color: Color(0xFFE5E5E5),
          //         // color: Colors.redAccent,
          //       ),
          //       boxShadow: [BoxShadow(
          //         offset: Offset(0, 1.5),
          //         blurRadius: 2,
          //         // color: Colors.purple,
          //         // color: Colors.black38,
          //       ),]
          // ),
          child: new ExpansionTile(
                // backgroundColor: Colors.purple[300],
                // initiallyExpanded:opentile?true:false,
                leading: Imagebox(photoUrl: photoUrl,),
                title: Text(
                  countryData[index]['Country'].toString(),
                  style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.w300),
                  // style: Theme.of(context).textTheme.title,
                ),
                children: <Widget>[
                  Divider(thickness: 1.0, color: Colors.black54,indent: 25.0,endIndent: 25.0,),
                  // SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                        Container(
                          // margin: EdgeInsets.only(left: 16.0),
                          padding: const EdgeInsets.all(4),
                          child: Column(children: [
                            TextData( "NewConfirmed",
                                countryData[index]['NewConfirmed']),
                            TextData( "NewDeaths",
                                countryData[index]['NewDeaths']),
                            TextData( "NewRecovered",
                                countryData[index]['NewRecovered']),
                          ]),
                          color: Colors.transparent,
                          // width: MediaQuery.of(context).size.width,
                        ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        child: Column(children: [
                          TextData( "TotalConfirmed",
                              countryData[index]['TotalConfirmed']),
                          TextData( "TotalDeaths",
                              countryData[index]['TotalDeaths']),
                          TextData( "TotalRecovered",
                              countryData[index]['TotalRecovered']),
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