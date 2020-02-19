import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionsList;
  final Function deleteHandler;

  TransactionList(this.transactionsList, this.deleteHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactionsList.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transactions yet!',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 20,
                ),
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
                  elevation: 2,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                              '\$${transactionsList[index].amount.toStringAsFixed(2)}'),
                        ),
                      ),
                    ),
                    title: Text(
                      '${transactionsList[index].title}',
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactionsList[index].date),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => deleteHandler(index),
                    ),
                  ),
                );
//                return Card(
//                  child: Row(
//                    children: <Widget>[
//                      Container(
//                        margin: EdgeInsets.symmetric(
//                          vertical: 10,
//                          horizontal: 15,
//                        ),
//                        decoration: BoxDecoration(
//                          border: Border.all(
//                            color: Theme.of(context).primaryColor,
//                            width: 2,
//                          ),
//                        ),
//                        padding: EdgeInsets.all(10),
//                        child: Text(
//                          '\$${transactionsList[index].amount.toStringAsFixed(2)}',
//                          style: TextStyle(
//                            fontSize: 20,
//                            fontWeight: FontWeight.bold,
//                            color: Theme.of(context).primaryColor,
//                          ),
//                        ),
//                      ),
//                      Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Text(
//                            transactionsList[index].title,
//                            style: Theme.of(context).textTheme.title,
//                          ),
//                          Text(
//                            DateFormat.yMd()
//                                .format(transactionsList[index].date),
//                            style: TextStyle(
//                              color: Colors.grey,
//                            ),
//                          ),
//                        ],
//                      ),
//                    ],
//                  ),
//                );
              },
              itemCount: transactionsList.length,
            ),
    );
  }
}
