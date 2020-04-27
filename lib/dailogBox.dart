import 'package:flutter/material.dart';
import 'pieChart.dart';

class DailogBox extends StatelessWidget {
  final Map countryData;
  final BuildContext context;
  DailogBox(
    this.context,
    this.countryData,
  );

  // const DailogBox({Key key}) : super(key: key);
  // const DailogBox({Map countryData}) : super(countryData: countryData);

  @override
  Widget build(BuildContext context) {
    String heading;
    if(countryData['Country']==null){
      heading="Global";
    }
    else{
      heading=countryData['Country'].toString();
    }
    if(countryData['state']!=null){
      heading=countryData['state'].toString();
    }
    return Container(
      child: SimpleDialog(
        backgroundColor: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Text(
                    heading,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 34,
                        fontWeight: FontWeight.w300),
                    // style: Theme.of(context).textTheme.title,
                  ),
                ),
                Divider(thickness: 1.0, color: Colors.black26,indent: 15.0,endIndent: 15.0,),
                // SizedBox(height: 20.0),
                PieChartSample2(context, countryData),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
