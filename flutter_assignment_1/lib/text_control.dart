// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class TextControl extends StatelessWidget {
  final Function textChange;

  TextControl(this.textChange);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: textChange, child: Text('Press to change text'));
  }
}
