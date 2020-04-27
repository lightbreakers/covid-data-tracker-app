import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './failed.dart';
import 'scrolllist.dart';
import 'india.dart';
import 'package:provider/provider.dart';
import 'statePages.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
// import 'package:Covid/serializers.dart' as md;
// import 'package:Covid/summary.dart';

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

class _MyHomePageState extends State<MyHomePage> {
  List countryData = [];
  Map globalData;
  Map indiaData;
  String dateData;
  int invalid = 0;
  String message = "0";

  Future<String> getData() async {
    // print('fetching data using getdata');
    try {
      var response = await http.get(
          Uri.encodeFull("https://api.covid19api.com/summary"),
          headers: {"Accept": "application/json"});
      // print("country data");

      setState(() {
        // <Summary> summary=response.body;
        countryData = json.decode(response.body)["Countries"];
        globalData = json.decode(response.body)["Global"];
        dateData = json.decode(response.body)["Date"];
        dateData = dateData.replaceAll(new RegExp(r'T'), ' ');
        dateData = dateData.replaceAll(new RegExp(r'Z'), ' ');
      });
      getIndiaData();
      return "Success";
    } catch (e) {
      // print("Failed");
      // print(e);
      setState(() {
        invalid = 1;
      });
      return "Failed";
    }
  }

  Future<String> getIndiaData() async {
    // print('inside getdata');
    try {
      var response = await http.get(
          // Uri.encodeFull("https://api.covid19india.org/state_district_wise.json"),
          Uri.encodeFull("https://api.covid19india.org/data.json"),
          headers: {"Accept": "application/json"});
      // print("india Body");
      setState(() {
        // <Summary> summary=response.body;
        indiaData = json.decode(response.body);
        // countryData = json.decode(response.body)["Countries"];
      });
      // print(indiaData);
      return "Success";
    } catch (e) {
      // print("Failed");
      // print(e);
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
      // page = 0;
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StatePage()),
      ],
      child: Consumer<StatePage>(
        builder: (context, statepage, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Covid-19",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.w400)),
              // backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              bottomOpacity: 1.0,
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    var val = await showSearch(
                        context: context,
                        delegate: CountrySearch(countryData,
                            indiaData['statewise'], statepage.page));
                    // print("Search");
                    // print(val);
                    var x;
                    if (statepage.page == 0) {
                      x = countryData.indexWhere((e) {
                        if (e['Country'] == val[0]['Country'])
                          return true;
                        else
                          return false;
                      });
                      Provider.of<StatePage>(context, listen: false)
                          .countryIndex(x);
                    }
                    if (statepage.page == 1) {
                      x = indiaData['statewise'].indexWhere((e) {
                        if (e['state'] == val[0]['state'])
                          return true;
                        else
                          return false;
                      });
                      Provider.of<StatePage>(context, listen: false)
                          .stateIndex(x);
                    }

                    // itemScrollController.scrollTo(
                    // index: x,
                    // duration: Duration(seconds: 2),
                    // curve: Curves.decelerate);
                    // print("DONE");
                  },
                ),
              ],
            ),
            body: new RefreshIndicator(
              onRefresh: () async {
                // print("onrefressh");
                await getData();
              },
              child: invalid == 1
                  ? Failed(resetState: reset)
                  :statepage.page == 0
                    ? Scrolllist(context, countryData, globalData, dateData)
                    : India(context, indiaData)),
            //       : Scrolllist(context, countryData, globalData, dateData),
            // ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              currentIndex: statepage.page,
              items: [
                BottomNavigationBarItem(
                    title: Text("Country",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 13,
                            fontWeight: FontWeight.w400)),
                    icon: Icon(Icons.toc)),
                BottomNavigationBarItem(
                    title: Text("India",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 13,
                            fontWeight: FontWeight.w400)),
                    icon: Icon(Icons.calendar_view_day)),
              ],
              onTap: (index) {
                if (index == 0) {
                  // print('bottom bar 0');
                  Provider.of<StatePage>(context, listen: false).pagechange(0);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => Scrolllist(
                  //           context, countryData, globalData, dateData)),
                  // );
                } else {
                  // print('bottom bar 1');
                  Provider.of<StatePage>(context, listen: false).pagechange(1);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => India(context, indiaData)),
                  // );
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class CountrySearch extends SearchDelegate<List> {
  final List countryData;
  final List indiaData;
  int page;
  CountrySearch(this.countryData, this.indiaData, this.page);

  List _suggestionList = [];
  List _searchresult = [];

  void _filterCountry(String searchFilter) {
    _suggestionList = [];
    countryData.forEach((p) => {
          if (p['Country'].toLowerCase().contains(searchFilter.toLowerCase()))
            {_suggestionList.add(p)}
        });
  }

  void _filterState(String searchFilter) {
    _suggestionList = [];
    indiaData.forEach((p) => {
          if (p['state'].toLowerCase().contains(searchFilter.toLowerCase()))
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
            // print('suggestion');
            if (page == 0) {
              query = _suggestionList[index]['Country'];
              _searchresult.add(_suggestionList[index]);
            }
            if (page == 1) {
              query = _suggestionList[index]['state'];
              _searchresult.add(_suggestionList[index]);
            }
            close(context, _searchresult);
          },
          child: page == 0
              ? Container(
                  margin: EdgeInsets.only(left: 16.0),
                  padding: const EdgeInsets.all(4),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _suggestionList[index]['Country'],
                    style: Theme.of(context).textTheme.headline,
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(left: 16.0),
                  padding: const EdgeInsets.all(4),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _suggestionList[index]['state'],
                    style: Theme.of(context).textTheme.headline,
                  ),
                ),
        );
      },
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (page == 0) {
      _filterCountry(query);
    }
    if (page == 1) {
      _filterState(query);
    }
    return Container(
      child: ListView.builder(
        itemCount: _suggestionList?.length,
        itemExtent: 60.0,
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
              onTap: () {
                // print('suggestion');
                if (page == 0) {
                  query = _suggestionList[index]['Country'];
                  _searchresult.add(_suggestionList[index]);
                }
                if (page == 1) {
                  query = _suggestionList[index]['state'];
                  _searchresult.add(_suggestionList[index]);
                }
                close(context, _searchresult);
              },
              child: page == 0
                  ? Container(
                      margin: EdgeInsets.only(left: 16.0),
                      padding: const EdgeInsets.all(4),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _suggestionList[index]['Country'],
                        style: Theme.of(context).textTheme.headline,
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(left: 16.0),
                      padding: const EdgeInsets.all(4),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _suggestionList[index]['state'],
                        style: Theme.of(context).textTheme.headline,
                      ),
                    ));
        },
      ),
    );
  }
}
