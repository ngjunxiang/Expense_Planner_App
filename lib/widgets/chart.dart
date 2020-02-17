import 'package:expense_planner_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0;
      for (var t in recentTransactions) {
        if (t.date.day == weekday.day &&
            t.date.month == weekday.month &&
            t.date.year == weekday.year) {
          totalSum += t.amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalSum,
      };
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((t) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                t['day'],
                t['amount'],
                totalSpending == 0.0 ? 0.0 : t['amount'] / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
