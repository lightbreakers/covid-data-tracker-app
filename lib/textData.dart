import 'package:flutter/material.dart';

class TextData extends StatelessWidget {
  // const name({name name}) : super(name: name);
  final String name;
  final int value;
  TextData(
    this.name,
    this.value,
  );

  Color colorCal(String name) {
    if (name == "New Confirmed") return Colors.orange;
    if (name == "New Deaths") return Colors.red;
    if (name == "New Recovered") return Colors.green;
    if (name == "Total Confirmed") return Colors.orange;
    if (name == "Total Deaths") return Colors.red;
    if (name == "Total Recovered") return Colors.green;
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      padding: EdgeInsets.all(4),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        elevation: 4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(3, 2, 3, 0),
              child: Text(
                  value.toString().replaceAllMapped(
                      new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                      (Match m) => '${m[1]},'),
                  style: TextStyle(color: colorCal(name), fontSize: 28)),
            ),
            // Divider(thickness: 1.0, color: Colors.purpleAccent,indent: 20.0,endIndent: 20.0,),
            Padding(
              padding: const EdgeInsets.fromLTRB(3, 0, 3, 2),
              child: Text(
                name,
                style: TextStyle(color: Colors.black38, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
