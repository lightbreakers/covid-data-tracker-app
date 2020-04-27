import 'package:Covid/indiaWidget/stateList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'countryPage.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'statePages.dart';
import 'snackBar.dart';

class Scrolllist extends StatefulWidget {
  // const Scrolllist({Key key}) : super(key: key);
  final List countryData;
  final BuildContext context;
  final Map globalData;
  final String dateData;

  Scrolllist(
    this.context,
    this.countryData,
    this.globalData,
    this.dateData,
  );

  @override
  _ScrolllistState createState() => _ScrolllistState();
}

// @override
// void initState() {
//   _presenter = new ScrolllistState(...);
// }
class _ScrolllistState extends State<Scrolllist> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  @override
  Widget build(BuildContext context) {
    final value = Provider.of<StatePage>(context).scrollCountry;
    var countrySet =
        Provider.of<StatePage>(context, listen: false).scrollCountrySet;
    // print('value country--------->$value');
    // print('countrySet--------->$countrySet');
    if (value > 1 && !(countrySet)) {
      itemScrollController.jumpTo(
        index: value,
      );
      Provider.of<StatePage>(context, listen: false).countrySet();
    }
    if (widget.countryData == null || widget.countryData.length < 1) {
      // if (countryData == []) {
      return Container(
        child: Center(
          child: Column(
            children: <Widget>[
              CircularProgressIndicator(),              
            ],
          ),
        ),
      );
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StatePage()),
      ],
      child: Consumer<StatePage>(
        builder: (context, statepage, _) {
          return ScrollablePositionedList.builder(
            itemScrollController: itemScrollController,
            itemPositionsListener: itemPositionsListener,
            itemCount: widget.countryData?.length,
            itemBuilder: (BuildContext context, int index) {
              return CountryPage(index, widget.countryData, widget.globalData,widget.dateData);
            },
          );
        },
      ),
    );
  }
}
