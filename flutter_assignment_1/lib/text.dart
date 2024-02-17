// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class OriginalText extends StatelessWidget {
  final String text;

  OriginalText(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
