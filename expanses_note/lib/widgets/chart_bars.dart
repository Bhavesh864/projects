import 'package:flutter/material.dart';

class ChartBars extends StatelessWidget {
  final String labelDay;
  final double spendingAmount;
  final double prcntOfSpendingAmnt;

  const ChartBars(this.labelDay, this.spendingAmount, this.prcntOfSpendingAmnt);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          Container(
            height: constraints.maxHeight * 0.14,
            child: FittedBox(
              child: Text('₹${spendingAmount.toStringAsFixed(0)}'),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.62,
            width: 10,
            child: Stack(
              // Stack widget place child widgets overlaying each other on z axis
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(220, 220, 220, 1),
                  ),
                ),
                FractionallySizedBox(
                  //Creates a widget that sizes its child to a fraction(definite percent) of the total available space.
                  heightFactor: prcntOfSpendingAmnt,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.14,
            child: FittedBox(
              child: Text(labelDay),
            ),
          ),
        ],
      );
    });
  }
}
