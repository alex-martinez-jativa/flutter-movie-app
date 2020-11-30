import 'package:flutter/material.dart';

linearGradient() {
  return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        Colors.red[900],
        Colors.red[500],
        Colors.red[700],
      ]);
}
