import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  // const Result({Key key}) : super(key: key);
  final int resultScore;
  final Function resetState;

  String get resultPhrase {
    var resultText;
    if (resultScore <= 5) {
      resultText = 'You did it!';
    } else if (resultScore <= 8) {
      resultText = 'Aaaa bumerrr';
    } else {
      resultText = 'Naught Boy';
    }
    return resultText;
  }

  Result({this.resultScore, this.resetState});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          FlatButton(
            child: Text("RESET"),
            color: Colors.amber,
            onPressed: resetState,
          ),
        ],
      ),
    );
  }
}
