import 'package:flutter/material.dart';

import 'result.dart';
import 'quiz.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;
  var _totalScore = 0;

  void _restartHandler() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _anwerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex++;
    });
  }

  var _questions = [
    {
      'question': "What's your favourite color?",
      'answers': [
        {'Text': 'Black', 'Score': 10},
        {'Text': 'Red', 'Score': 7},
        {'Text': 'Green', 'Score': 3},
        {'Text': 'Blue', 'Score': 5}
      ]
    },
    {
      'question': "What's your favourite animal?",
      'answers': [
        {'Text': 'Lion', 'Score': 10},
        {'Text': 'Zebra', 'Score': 4},
        {'Text': 'Dog', 'Score': 3},
        {'Text': 'Leopard', 'Score': 7}
      ]
    },
    {
      'question': "Who's is your Mentor ",
      'answers': [
        {'Text': 'Joseph', 'Score': 2},
        {'Text': 'Carnos', 'Score': 2},
        {'Text': 'Lepson', 'Score': 2},
        {'Text': 'Jessica', 'Score': 2}
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("My First Project"),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                answerQuestion: _anwerQuestion,
                questions: _questions,
                questionIndex: _questionIndex,
              )
            : Result(_totalScore, _restartHandler),
      ),
    );
  }
}
