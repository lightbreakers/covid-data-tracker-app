import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Imagebox extends StatelessWidget {
  // const Imagebox({Key key}) : super(key: key);
  final String photoUrl;
  // final Function resetState;
  Imagebox({this.photoUrl});

  @override
  Widget build(BuildContext context) {
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
