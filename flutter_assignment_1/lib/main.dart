// ignore_for_file: prefer_const_constructors
// 1) Create a new Flutter App (in this project) and output an AppBar and some text
// below it
// 2) Add a button which changes the text (to any other text of your choice)
// 3) Split the app into three widgets: App, TextControl & Text
import 'package:flutter/material.dart';
import 'text.dart';
import 'text_control.dart';

void main() => runApp(MyAssignment());

class MyAssignment extends StatefulWidget {
  const MyAssignment({Key key}) : super(key: key);

  @override
  State<MyAssignment> createState() => _MyAssignmentState();
}

class _MyAssignmentState extends State<MyAssignment> {
  String _text = 'Press the button to change the text here!';

  _changeHandler() {
    setState(() {
      _text = 'Awesome! You successfully change text🥳';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Assignment'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OriginalText(_text),
            SizedBox(height: 20),
            TextControl(_changeHandler),
          ],
        ),
      ),
    );
  }
}
