import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          //CircleAvatar display amount round
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 6),
            child: FittedBox(
                //FittedBox used to adjust higher values like 122232443 to decrease their size as small as possible to fit in that widget
                child: Text('₹ ${transaction.amount}')),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.titleLarge, //using theme text
        ),
        subtitle: Text('${DateFormat.yMMMd().format(transaction.date)}'),
        trailing: IconButton(
          onPressed: () => deleteTx(transaction.id),
          icon: const Icon(Icons.delete),
          color: Theme.of(context).errorColor,
        ),
      ),
    );
  }
}
