import 'package:flutter/material.dart';

import './quiz.dart';
import './result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}



class _MyAppState extends State<MyApp> {
  var _queIndex = 0;
  var _totalScore = 0;
  final _que = const [
    {
      'que': 'What your Name ?',
      "ans": [{"text":"Harsh","score":1},{"text":"Yash","score":2},{"text":"Adamya","score":4} ]
    },
    {
      'que': "How old are you ?",
      "ans": [{"text":"2","score":1},{"text":"2","score":3},{"text":"5","score":4} ]
    },
    {
      'que': "Where were you born?",
      "ans": [{"text":"Mumbai","score":2},{"text":"Nagpur","score":3} ,{"text":"Pune","score":5}]
    }
  ];

  void _ansQuestion(int score) {
    _totalScore +=score;
    setState(() {
      _queIndex = _queIndex + 1;
      print(_totalScore);
    });
  }
  void _reset() {
    // _totalScore +=score;
    setState(() {
      _queIndex = 0;
      _totalScore=0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('EPIC SHIT LOADING'),
        ),
        body: _queIndex < _que.length
            ? Quiz(answerQuestion: _ansQuestion,que: _que, queIndex: _queIndex)
            : Result(resultScore:_totalScore,resetState:_reset),
      ),
    );
  }
}
