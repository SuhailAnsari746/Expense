import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './chartbar.dart';

class DayAmount extends StatelessWidget {
  final List<Transaction> forCharts;
  DayAmount(this.forCharts);
  List<Map<String, Object>> get currentDateAmount {
    return List.generate(
      7,
      (index) {
        final weekDays = DateTime.now().subtract(
          Duration(days: index),
        );
        double amount = 0.0;
        for (var i = 0; i < forCharts.length; i++) {
          if (forCharts[i].date.day == weekDays.day &&
              forCharts[i].date.month == weekDays.month &&
              forCharts[i].date.year == weekDays.year)
            amount += forCharts[i].amount;
        }
        //   print(amount);
        // print(DateFormat.E(weekDays));
        return {
          'day': DateFormat.E().format(weekDays).substring(0, 2),
          'amount': amount,
        };
      },
    ).reversed.toList();
  }

  double get calcpercentage {
    return currentDateAmount.fold(0.0, (sum, item) {
      return sum += item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin:EdgeInsets.all(20),
      child: Padding(
        padding:  EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: currentDateAmount.map((data) {
            return Flexible(
              fit: FlexFit.tight,
                        child: MyChartBar(
                sdays: data['day'],
                spendingAmount: data['amount'],
                perAmount: calcpercentage==0.0?0.0 :(data['amount'] as double) / calcpercentage,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
