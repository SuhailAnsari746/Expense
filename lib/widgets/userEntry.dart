import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// isko stateful kun kiya
class UserEntry extends StatefulWidget {
  final Function cntrHandler;
  UserEntry(this.cntrHandler);

  @override
  _UserEntryState createState() => _UserEntryState();
}

class _UserEntryState extends State<UserEntry> {
  final titleInput = TextEditingController();
  final amountInput = TextEditingController();
  DateTime selectedDate;

  void subm() {
    if (amountInput.text.isEmpty) {
      return;
    }
    final haveTitle = titleInput.text;
    final haveAmount = double.parse(amountInput.text);

    if (haveTitle.isEmpty || haveAmount <= 0 || selectedDate == null) {
      {
        Text('Please enter a valid data',style: TextStyle(
          color:Colors.red,
          fontStyle: FontStyle.italic,
        ),);
        return;
      }
    }
    widget.cntrHandler(haveTitle, haveAmount, selectedDate);
    Navigator.of(context).pop();
  }

  void selectingDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 30)),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      setState(() {
        if (pickedDate == null) return;
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 6,
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          //  height: constraints.maxHeight * 0.6,
          child: Column(
            children: <Widget>[
              TextField(
                cursorColor: Colors.purple,
                decoration: InputDecoration(labelText: "Title"),
                controller: titleInput,
                onSubmitted: (_) => subm(),
              ),
              TextField(
                enableSuggestions: true,
                cursorColor: Colors.purple,
                decoration: InputDecoration(labelText: "Amount(\$) "),
                keyboardType: TextInputType.number,
                controller: amountInput,
                onSubmitted: (_) => subm(),
              ),
              Container(
                //      height: constraints.maxHeight * 0.2,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      fit: FlexFit.tight,
                      child: Text(
                        selectedDate == null
                            ? "No Date Chosen !"
                            : DateFormat.MMMEd().format(selectedDate),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "OpenSans",
                            fontSize: 16),
                      ),
                    ),
                    FlatButton(
                      child: Text(
                        "Select a date",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "OpenSans",
                          fontSize: 16,
                          color: Theme.of(context).primaryColor,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      onPressed: selectingDate,
                    ),
                  ],
                ),
              ),
              Container(
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    "Add Transaction",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: subm,
                  //color:Colors.purple,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
