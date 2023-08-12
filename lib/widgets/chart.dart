import 'package:expenses_app/widgets/chart_bar.dart';
import 'package:expenses_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import './chart_bar.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<transaction> recentTransaction;

  Chart(this.recentTransaction);
  List<Map<String, Object>> get groupedtransactions {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      double totalsum = 0;

      for (int i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].day.day == weekday.day &&
            recentTransaction[i].day.month == weekday.month &&
            recentTransaction[i].day.year == weekday.year) {
          totalsum += recentTransaction[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalsum
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedtransactions.fold(0.0, (sum, element) {
      return sum + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 8,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: groupedtransactions.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    data['day'] as String,
                    data['amount'] as double,
                    maxSpending == 0.0
                        ? 0.0
                        : (data['amount'] as double) / maxSpending),
              );
            }).toList(),
          ),
        ));
  }
}
