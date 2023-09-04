
import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
   MyText({required this.text, required this.color, this.fontWeight}) ;

  String text;
  Color color;
  FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color, fontWeight: fontWeight),
    );
  }
}
