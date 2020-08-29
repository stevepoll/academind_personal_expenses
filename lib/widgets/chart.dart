import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTxns;

  Chart(this.recentTxns);

  double get totalSum {
    return recentTxns.fold(0, (acc, tx) => acc + tx.amount);
  }

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double dailySum = recentTxns
          .where((txn) {
            return txn.date.day == weekDay.day &&
                txn.date.month == weekDay.month &&
                txn.date.year == weekDay.year;
          })
          .toList()
          .fold(0, (acc, t) => acc + t.amount);

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': dailySum
      };
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((txn) {
            String day = txn['day'];
            double amt = txn['amount'];
            double total = totalSum == 0.0 ? 0.0 : amt / totalSum;

            return ChartBar(day, amt, total);
          }).toList(),
        ),
      ),
    );
  }
}
