import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:personal_expenses/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> txns;
  final Function deleteTxn;

  TransactionList(this.txns, this.deleteTxn);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: txns.isEmpty
          ? Column(
              children: [
                Text(
                  'No Transactions Yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 10),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  elevation: 5,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('\$${txns[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      txns[index].title,
                      style: Theme.of(ctx).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMMd().format(txns[index].date),
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => deleteTxn(txns[index].id),
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                );
              },
              itemCount: txns.length,
            ),
    );
  }
}
