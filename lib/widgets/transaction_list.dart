import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:personal_expenses/models/transaction.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> txns;
  final Function deleteTxn;

  TransactionList(this.txns, this.deleteTxn);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  Widget deleteIcon(BuildContext context, String txnId) {
    final icon = Icon(Icons.delete);
    final onPressed = () => widget.deleteTxn(txnId);
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
    return widget.txns.isEmpty
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
                        child: Text('\$${widget.txns[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text(
                    widget.txns[index].title,
                    style: Theme.of(ctx).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMMd().format(widget.txns[index].date),
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  trailing: deleteIcon(context, widget.txns[index].id),
                ),
              );
            },
            itemCount: widget.txns.length,
          );
  }
}
