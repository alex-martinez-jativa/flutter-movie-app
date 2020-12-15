import 'package:flutter/material.dart';

class FeedbackMessage extends StatelessWidget {
  final String text;
  final String color;

  FeedbackMessage({@required this.text, @required this.color});

  @override
  Widget build(BuildContext context) {
    var _color;
    if (color == 'warning') {
      _color = Colors.red;
    }
    if (color == 'info') {
      _color = Colors.blue;
    }
    if (color == 'success') {
      _color = Colors.green;
    }
    return Text(
      text,
      style: TextStyle(color: _color),
    );
  }
}
