import 'package:flutter/material.dart';
import './question.dart';
import './answer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class Album {
  // final BigInt totalConfirmed;
  // final BigInt totalDeaths;
  // final String country;
  final Map global;

  // Album({this.totalConfirmed, this.totalDeaths, this.country});
  Album({this.global});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      global:json['Global'],
    //   totalConfirmed: json['TotalConfirmed'],
    //   totalDeaths: json['TotalDeaths'],
    //   country: json['Country'],

    // NewConfirmed": 77058,
    //     "TotalConfirmed": 1645876,
    //     "NewDeaths": 6008,
    //     "TotalDeaths": 105747,
    //     "NewRecovered": 22527,
    //     "TotalRecovered": 344091


    );
  }
}
class Quiz extends StatelessWidget {
  // const name({Key key}) : super(key: key);
  final List<Map<String, Object>> que;
  final Function answerQuestion;
  final int queIndex;

  Quiz({
      @required this.answerQuestion,
      @required this.que,
      @required this.queIndex});

  
  
  Future<Album> fetchAlbum() async {
    final response = await http.get('https://api.covid19api.com/summary');
    // final response = await http.get('https://jsonplaceholder.typicode.com/albums/1');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print('fetch album');
      print(Album.fromJson(json.decode(response.body)).toString());
      print(json.decode(response.body));
      return Album.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(
          que[queIndex]["que"],
        ),
        ...(que[queIndex]['ans'] as List<Map<String, Object>>).map((answer) {
          return Answer(()=>answerQuestion(answer["score"]), answer["text"]);
        }).toList(),
        RaisedButton(
        padding: EdgeInsets.all(12),
        color: Colors.redAccent,
        textColor: Colors.white,
        child: Text("COVIDAPI"),
        onPressed: ()=>fetchAlbum().then((onValue){
          print("APIRESPONSE");
          print(onValue);
          FlatButton(
            child: Text("COVIDREULTS"),
            color: Colors.amber,
            onPressed: null, 
          );


        },
        // child: Text('Get data'),
        ),
      ),
      ],
    );
  }
}
