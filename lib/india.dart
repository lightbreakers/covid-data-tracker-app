import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'indiaWidget/stateList.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'statePages.dart';

class India extends StatefulWidget {
  final BuildContext context;
  final Map indiaData;

  India(
    this.context,
    this.indiaData,
  );

  @override
  _IndiaState createState() => _IndiaState();
}

class _IndiaState extends State<India> {
  List indiaCountrydata = [];
  final ItemScrollController itemScrollController = ItemScrollController();

  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  @override
  Widget build(BuildContext context) {
    indiaCountrydata = widget.indiaData['statewise'];

    final value = Provider.of<StatePage>(context).scrollState;
    var stateSet= Provider.of<StatePage>(context, listen: false).scrollStateSet;
    // print('value state--------->$value');
    if (value > 1 && !(stateSet)) {
      itemScrollController.jumpTo(
        index: Provider.of<StatePage>(context).scrollState,
      );
      Provider.of<StatePage>(context, listen: false).stateSet();
    }

    if (widget.indiaData == null || widget.indiaData.length < 1) {
      // if (indiaData == []) {
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
            itemCount: indiaCountrydata?.length,
            itemBuilder: (BuildContext context, int index) {
              return Statelist(context, indiaCountrydata, index);
            },
          );
        },
      ),
    );
  }
}
