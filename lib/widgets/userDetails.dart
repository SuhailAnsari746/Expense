import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './properties.dart';

class UserList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function del;
  UserList(this.transactions, this.del);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Text("NO TRANSACTION YET", style: AppBarStyle),
                    margin: EdgeInsets.only(bottom: 20),
                  ),
                  Container(
                    height: constraints.maxHeight * 0.50,
                    child: Image.asset(
                      'font/image/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 6,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                              child: Text(
                                  '\$${transactions[index].amount.toStringAsFixed(2)}')),
                        ),
                      ),
                      title: Text(transactions[index].product,
                          style: ProductStyleTheme),
                      subtitle: Text(
                          DateFormat.MEd().format(transactions[index].date)),
                      trailing: MediaQuery.of(context).size.width > 460
                          ? FlatButton.icon(
                              onPressed: () {
                                del(transactions[index].id);
                              },
                              icon: Icon(Icons.delete),
                              textColor: Theme.of(context).errorColor,
                              label: Text("Delete"),
                            )
                          : IconButton(
                              icon: Icon(Icons.delete),
                              color: Theme.of(context).errorColor,
                              onPressed: () {
                                del(transactions[index].id);
                              })),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
