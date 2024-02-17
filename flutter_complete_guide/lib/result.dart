import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function restartHandler;

  Result(this.resultScore, this.restartHandler);

  String get resultPhrase {
    String resultView;

    if (resultScore <= 8) {
      resultView = 'You are Awesome and Innocent!😇';
    } else if (resultScore <= 12) {
      resultView = 'You are Pretty Likeable!👍';
    } else if (resultScore <= 18) {
      resultView = 'You are ... Strange!🧐';
    } else {
      resultView = 'You are Terrific! 🙅‍♀️';
    }

    return resultView;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 30),
          Text(
            resultPhrase,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          OutlinedButton(
              onPressed: restartHandler,
              child: Text(
                'Restart!🕹️',
                style: TextStyle(color: Colors.black),
              ))
        ],
      ),
    );
  }
}
