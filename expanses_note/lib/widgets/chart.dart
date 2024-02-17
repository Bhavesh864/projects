import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bars.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    //Generate list of data of 7 days
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  //Total amount of spending of whole week
  double get totalSpendingOfWeek {
    // Fold method is used to generate sum of whole list (i.e list of all 7 days)
    return groupedTransactionValues.fold(0.0, (previousSum, currItem) {
      return previousSum + currItem['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              //Flexible.tight property flexes their child accordingly
              //Expanded widget is also an option to do this tight flex
              child: ChartBars(
                data['day'],
                data['amount'],
                totalSpendingOfWeek == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalSpendingOfWeek,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
