import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'dart:convert';
import 'package:country_icons/country_icons.dart';
import './failed.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          buttonColor: Colors.purple,
          buttonTheme:
              const ButtonThemeData(textTheme: ButtonTextTheme.primary)),
      home: MyHomePage(title: 'Flutter Api Call'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// CountryData class

// class CountryData{
//   final String country;
//   final String countryCode;
//   final String newConfirmed;
//   final String totalConfirmend;
//   final String newDeaths;
//   final String totalsDeaths;
//   final String newRecovered;
//   final String totalRecovered;
//   final Map global;
//   final Map countries;

//   const CountryData(this.global, this.countries, 
//     {this.country, 
//     this.countryCode, this.newConfirmed, this.totalConfirmend,
//     this.newDeaths, this.totalsDeaths, this.newRecovered, this.totalRecovered}
//     );

//     factory CountryData.fromJson(Map<String,dynamic> json){
//       if(json==null)
//       return null;
 
//       return CountryData(
//         country: json
//         )

//     }
// }

//
class _MyHomePageState extends State<MyHomePage> {
  final ItemScrollController itemScrollController = ItemScrollController();
final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  List countryData = [];
  Map globalData;
  int invalid = 0;
  String message = "0";

  Future<String> getData() async {
    print('inside getdata');
    try {
      var response = await http.get(
          // Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
          Uri.encodeFull("https://api.covid19api.com/summary"),
          // Uri.encodeFull("https://api.covid19api.com/all"),
          headers: {"Accept": "application/json"});
      print("Body");
      // print(response.body);
      print(json.decode(response.body));
      setState(() {
        countryData = json.decode(response.body)["Countries"];
        globalData = json.decode(response.body)["Global"];
        // countryData = json.decode(response.body);
      });
      return "Success";
    } catch (e) {
      // print("Failed");
      print(e);
      setState(() {
        invalid = 1;
      });
      return "Failed";
    }
  }

  void reset() {
    setState(() {
      countryData = [];
      invalid = 0;
    });
    getData();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("COVID"),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              var val = await showSearch(
                  context: context, delegate: CountrySearch(countryData));
              print("Search");
              print(val);
              var x = countryData.indexWhere(
                (e){
                  if(e['Country']==val[0]['Country'])
                  return true;
                  else
                  return false;
              });
              // itemScrollController.scrollTo(
              // index: x,
              // duration: Duration(seconds: 4),
              // curve: Curves.easeIn);
              itemScrollController.jumpTo(
              index: x,
              );
              print("DONE");
            },
          ),
        ],
      ),
      body: new RefreshIndicator(
            onRefresh:() async{
              print("onrefressh");
               await getData();
            },
              child: invalid == 1
            ? Failed(resetState: reset)
            : Container(
                child: getList(context),
              ),
      ),
    );
  }
//   _displaySnackBar(BuildContext context) {
//   final snackBar = SnackBar(content: Text('Are you talkin\' to me?'));
//   Scaffold.of(context).showSnackBar(snackBar);
// }
  
  Widget getList(context) {
    if (countryData == null || countryData.length < 1) {
      // if (countryData == []) {
      return Center(
        child: Column(
          children: <Widget>[
            Text(
              "Please wait..",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ScrollablePositionedList.builder(
      itemScrollController: itemScrollController,
      itemPositionsListener: itemPositionsListener,
      itemCount: countryData?.length,
      // itemExtent: 170.0,
      itemBuilder: (BuildContext context, int index) {
        return _buildItem(context, index);
      },
    );
  }

  Widget dailogBuilder(BuildContext context, countryData) {
    ThemeData localTheme = Theme.of(context);
    String photoUrl = "icons/flags/png/2.5x/" +
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

  Widget _imageBoxer(BuildContext context, String photoUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: Image.asset(
        photoUrl,
        package: 'country_icons',
        width: 65,
        height: 40,
        fit: BoxFit.fill,
      ),
      // fit: BoxFit.cover,
    );
  }

  Widget _textData(BuildContext context, String key, int value) {
    ThemeData localTheme = Theme.of(context);
    return Text(
      key + " : " + value.toString(),
      style: localTheme.textTheme.subhead.copyWith(fontStyle: FontStyle.italic),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    if (index == 0) {
      return Container(
        margin: EdgeInsets.all(4),
        child: Center(
          child: Text(
            "Latest Data",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
    String photoUrl = "icons/flags/png/2.5x/" +
        countryData[index]["CountryCode"].toLowerCase() +
        ".png";
    return new GestureDetector(
        onTap: () => showDialog(
              context: context,
              builder: (context) => dailogBuilder(context, countryData[index]),
            ),
        child: Padding(
          key: Key(countryData[index]['Country']),
          padding: const EdgeInsets.all(8.0),
          child: new ExpansionTile(
              // initiallyExpanded:opentile?true:false,
              leading: _imageBoxer(context, photoUrl),
              title: Text(
                countryData[index]['Country'].toString(),
                style: Theme.of(context).textTheme.title,
              ),
              children: <Widget>[
                Divider(thickness: 2.0,color: Colors.black54),
                // SizedBox(height: 4.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                   Container(
                      // margin: EdgeInsets.only(left: 16.0),
                      padding: const EdgeInsets.all(8),
                      child: Column(children: [
                          _textData(context, "NewConfirmed",
                              countryData[index]['NewConfirmed']),
                          _textData(context, "NewDeaths",
                              countryData[index]['NewDeaths']),
                          _textData(context, "NewRecovered",
                              countryData[index]['NewRecovered']),
                        ]),
                      // color: Colors.blueAccent,
                      // width: MediaQuery.of(context).size.width,
                    ),
                  Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(children: [
                          _textData(context, "TotalConfirmed",
                              countryData[index]['TotalConfirmed']),
                          _textData(context, "TotalDeaths",
                              countryData[index]['TotalDeaths']),
                          _textData(context, "TotalRecovered",
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

class CountrySearch extends SearchDelegate<List> {
  final List countryData;

  CountrySearch(this.countryData);

  List _suggestionList = [];
  List _searchresult = [];

  // populate _personList
  void _filter(String searchFilter) {
    _suggestionList = [];
    countryData.forEach((p) => {
          if (p['Country'].toLowerCase().contains(searchFilter.toLowerCase()))
            {_suggestionList.add(p)}
        });
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => {close(context, null)},
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
        child: ListView.builder(
      itemCount: _suggestionList?.length,
      itemExtent: 60.0,
      itemBuilder: (BuildContext context, int index) {
        return new GestureDetector(
            onTap: () {
              print('results');
              print(_suggestionList[index]);

              // close(context, _searchresult);
            },
            child: Container(
              margin: EdgeInsets.only(left: 16.0),
              padding: const EdgeInsets.all(4),
              alignment: Alignment.centerLeft,
              child: Text(
                _suggestionList[index]['Country'],
                style: Theme.of(context).textTheme.headline,
              ),
            ));
      },
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _filter(query);
    return Container(
        child: ListView.builder(
      itemCount: _suggestionList?.length,
      itemExtent: 60.0,
      itemBuilder: (BuildContext context, int index) {
        return new GestureDetector(
            onTap: () {
              print('suggestion');
              query = _suggestionList[index]['Country'];
              print(_suggestionList[index]);
              _searchresult.add(_suggestionList[index]);
              close(context, _searchresult);
            },
            child: Container(
              margin: EdgeInsets.only(left: 16.0),
              padding: const EdgeInsets.all(4),
              alignment: Alignment.centerLeft,
              child: Text(
                _suggestionList[index]['Country'],
                style: Theme.of(context).textTheme.headline,
              ),
            ));
      },
    ));
  }
}
