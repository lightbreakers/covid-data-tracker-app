import 'package:flutter/material.dart';

class TextData extends StatelessWidget {
  // const name({name name}) : super(name: name);
  final String name;
  final int value;
  TextData(this.name,this.value,);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      child: Card(
        
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        elevation: 10,
        child: Column(
          
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(3, 2, 3, 0),
              child: Text(value.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 28)),
            ),
            Divider(thickness: 1.0, color: Colors.purpleAccent,indent: 20.0,endIndent: 20.0,),
            Padding(
              padding: const EdgeInsets.fromLTRB(3, 0, 3, 2),
              child: Text(name, style: TextStyle(color: Colors.black, fontSize: 15))
            ),
          ],
        ),
      ),
    );
  }
}