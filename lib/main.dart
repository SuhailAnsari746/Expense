import 'dart:io';
import 'package:flutter/material.dart';
import './widgets/UserDetails.dart';
import './widgets/userEntry.dart';
import './models/transaction.dart';
import './widgets/properties.dart';
import './widgets/char.dart';
void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([
  // DeviceOrientation.portraitUp,
  //DeviceOrientation.portraitDown,
  //]);
  runApp(MyBase());
}

class MyBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
         MaterialApp(
        title: "Personal Expense",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.teal,
            accentColor: Colors.amber,
            appBarTheme: AppBarTheme(
                textTheme: TextTheme(
              title: AppBarStyle,
            ))),
        home: MyHome()
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final List<Transaction> transactions = [];
  List<Transaction> get recentTransaction {
    return transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _connection(String title, double amount, DateTime seldate) {
    final tx = Transaction(
        product: title,
        amount: amount,
        date: seldate,
        id: DateTime.now().toString());
    setState(() {
      transactions.add(tx);
    });
  }

  void _connecting(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: UserEntry(_connection), // yahah pe
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void delConnection(String id) {
    setState(() {
      transactions.removeWhere((tx) => tx.id == id);
    });
  }

  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appbar = AppBar(
      title: Text("Weekly Kharcha"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _connecting(context);
          },
        )
      ],
    );
    final listShow = Container(
      height: (MediaQuery.of(context).size.height -
              appbar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: UserList(transactions, delConnection),
    );
    return Scaffold(
      appBar: appbar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (isLandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Show Chart", style: ProductStyleTheme),
                    Switch(
                        value: _showChart,
                        onChanged: (val) {
                          setState(() {
                            _showChart = val;
                          });
                        })
                  ],
                ),
              if (!isLandscape)
                Container(
                  height: (MediaQuery.of(context).size.height -
                          appbar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.3,
                  child: Card(
                    child: DayAmount(recentTransaction),
                  ),
                ),
              if (!isLandscape) listShow,
              if (isLandscape)
                _showChart == true
                    ? Container(
                        height: (MediaQuery.of(context).size.height -
                                appbar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            0.7,
                        child: Card(
                          child: DayAmount(recentTransaction),
                        ),
                      )
                    : listShow,
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              child: Icon(
                Icons.add,
              ),
              onPressed: () {
                _connecting(context);
              }),
    );
  }
}
