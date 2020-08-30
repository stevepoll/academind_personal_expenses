import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:personal_expenses/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> txns;
  final Function deleteTxn;

  TransactionList(this.txns, this.deleteTxn);

  Widget deleteIcon(BuildContext context, String txnId) {
    final icon = Icon(Icons.delete);
    final onPressed = () => deleteTxn(txnId);
    final color = Theme.of(context).errorColor;

    if (MediaQuery.of(context).size.width > 400) {
      return FlatButton.icon(
        onPressed: onPressed,
        icon: icon,
        label: Text('Delete'),
        textColor: color,
      );
    } else {
      return IconButton(
        icon: icon,
        onPressed: onPressed,
        color: color,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return txns.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  Text(
                    'No Transactions Yet!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
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
                  trailing: deleteIcon(context, txns[index].id),
                ),
              );
            },
            itemCount: txns.length,
          );
  }
}
