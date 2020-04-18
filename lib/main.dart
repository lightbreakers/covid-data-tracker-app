import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'dart:convert';
import './failed.dart';
import './mainList.dart';
import 'textData.dart';

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
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
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
        title: Text("Covid-19",
                          style: TextStyle(color: Colors.red, fontSize: 20,fontWeight: FontWeight.w400)),
        // backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        bottomOpacity: 1.0,
        actions: [
          IconButton(
            icon: Icon(Icons.search,color: Colors.red,),
            onPressed: () async {
              var val = await showSearch(
                  context: context, delegate: CountrySearch(countryData));
              print("Search");
              print(val);
              var x = countryData.indexWhere((e) {
                if (e['Country'] == val[0]['Country'])
                  return true;
                else
                  return false;
              });
              // itemScrollController.scrollTo(
              // index: x,
              // duration: Duration(seconds: 2),
              // curve: Curves.decelerate);
              itemScrollController.jumpTo(
                index: x,
              );
              print("DONE");
            },
          ),
        ],
      ),
      body: new RefreshIndicator(
        onRefresh: () async {
          print("onrefressh");
          await getData();
        },
        child: invalid == 1
            ? Failed(resetState: reset)
            : Container(
                child: getList(context),
              ),
              // ]
            // )
            
      ),
    );
  }

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


  Widget _buildItem(BuildContext context, int index) {
    if (index == 0) {
      return Column(          
                children: <Widget>[
                      AnimatedContainer(
                        curve: Curves.easeIn,
                        duration: Duration(seconds: 1),
                        padding: EdgeInsets.all(14),
                        margin: EdgeInsets.all(4),
                      //    decoration: BoxDecoration(
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
                          child: Text("Worldwide",
                          style: TextStyle(color: Colors.black, fontSize: 36 ,fontWeight: FontWeight.w200)),
                        ),
                  // Divider(thickness: 1.0, color: Colors.black54,indent: 25.0,endIndent: 25.0,),
                  // SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                        Container(
                          // margin: EdgeInsets.only(left: 16.0),
                          padding: const EdgeInsets.all(4),
                          child: Column(children: [
                            TextData( "NewConfirmed",
                                globalData['NewConfirmed']),
                            TextData( "NewDeaths",
                                globalData['NewDeaths']),
                            TextData( "NewRecovered",
                                globalData['NewRecovered']),
                          ]),
                          color: Colors.transparent,
                          // width: MediaQuery.of(context).size.width,
                        ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        child: Column(children: [
                          TextData( "TotalConfirmed",
                              globalData['TotalConfirmed']),
                          TextData( "TotalDeaths",
                             globalData['TotalDeaths']),
                          TextData( "TotalRecovered",
                              globalData['TotalRecovered']),
                        ]),
                        // color: Color.fromRGBO(0, 0, 0, 0),
                        // width: MediaQuery.of(context).size.width,
                      ),
                    ],
                  ),
                ],        
        );
    }
      
      
    //   Container(
    //     margin: EdgeInsets.all(4),
    //     child: Container(
    //       child: Center(
    //         child: Text(
    //           "Latest Data",
    //           style: TextStyle(
    //             fontSize: 22,
    //             // fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //       ),
    //     ),
    //   );
    // }
    return MainList(context,countryData,index);
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
