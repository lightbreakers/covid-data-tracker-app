import 'package:flutter/material.dart';

class DailogBox extends StatelessWidget {
  final Map countryData;
  final BuildContext context;
  DailogBox(this.context,this.countryData,);
  
  // const DailogBox({Key key}) : super(key: key);
  // const DailogBox({Map countryData}) : super(countryData: countryData);


  @override
  Widget build(BuildContext context) {
    ThemeData localTheme = Theme.of(context);
    final String photoUrl = "icons/flags/png/2.5x/" +
        countryData["CountryCode"].toLowerCase() +
        ".png";
    return SimpleDialog(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                countryData['Country'].toString(),
                style: localTheme.textTheme.display2,
              ),
              Divider(thickness: 2.0),
              SizedBox(height: 16.0),
              Image.asset(photoUrl, package: 'country_icons'),
              Text(
                "NewConfirmed : " + countryData['NewConfirmed'].toString(),
                style: localTheme.textTheme.subhead
                    .copyWith(fontStyle: FontStyle.italic),
              ),
              Text(
                "NewDeaths : " + countryData['NewDeaths'].toString(),
                style: localTheme.textTheme.subhead
                    .copyWith(fontStyle: FontStyle.italic),
              ),
              Text(
                "TotalConfirmed : " + countryData['TotalConfirmed'].toString(),
                style: localTheme.textTheme.subhead
                    .copyWith(fontStyle: FontStyle.italic),
              ),
              Text(
                "TotalDeaths : " + countryData['TotalDeaths'].toString(),
                style: localTheme.textTheme.subhead
                    .copyWith(fontStyle: FontStyle.italic),
              ),
              Text(
                "NewRecovered : " + countryData['NewRecovered'].toString(),
                style: localTheme.textTheme.subhead
                    .copyWith(fontStyle: FontStyle.italic),
              ),
              Text(
                "TotalRecovered : " + countryData['TotalRecovered'].toString(),
                style: localTheme.textTheme.subhead
                    .copyWith(fontStyle: FontStyle.italic),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Wrap(children: [
                  // FlatButton(
                  //   child: const Text('Ok'),
                  //   onPressed: () {},
                  // ),
                  RaisedButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ]),
              )
            ],
          ),
        ),
      ],
    );
  }
}