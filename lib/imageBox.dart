
import 'package:flutter/material.dart';

class Imagebox extends StatelessWidget {
  // const Imagebox({Key key}) : super(key: key);
  final String photoUrl;
  // final Function resetState;
  Imagebox({this.photoUrl});

  @override
  Widget build(BuildContext context) {
    // return (BuildContext context, String photoUrl) {
    return ClipRRect( 
      borderRadius: BorderRadius.circular(4.0),
      child: Image.asset(
        photoUrl,
        package: 'country_icons',
        width: 65,
        height: 40,
        fit: BoxFit.fill,
      ),
      // fit: BoxFit.cover,
    );
  }
}