import 'package:flutter/material.dart';

import '/models/transaction.dart';
import 'transaction_item.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  const TransactionsList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    //use aspectrtio widget instead
    // MediaQueryData queryData;
    // queryData = MediaQuery.of(context);
    //   height: queryData.size.height / 1.455,
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'No transactions added yet!',
                  style:
                      Theme.of(context).textTheme.titleSmall, //using themedata
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: constraints.maxHeight * 0.7,
                  child: Image.asset(
                    //Using images from assests folder
                    'assests/Images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })

        //ListView widget is scrollable by default
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return TransactionItem(
                  transaction: transactions[index], deleteTx: deleteTx);
            },
            itemCount: transactions.length,
          );
  }
}
