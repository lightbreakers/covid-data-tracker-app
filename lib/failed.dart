import 'package:flutter/material.dart';

class Failed extends StatelessWidget {
  // const Result({Key key}) : super(key: key);
  // final int resultScore;
  final Function resetState;
  Failed({this.resetState});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            "Oops something went wrong",
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          FlatButton(
            child: Text("RELOAD"),
            color: Colors.blueAccent,
            onPressed:resetState,
          ),
        ],
      ),
    );
  }
}