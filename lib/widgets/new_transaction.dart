import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addtransaction;

  NewTransaction(this.addtransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  DateTime _currentdate;
  final _amountController = TextEditingController();

  void _submitdata() {
    String _enteredTitle = _titleController.text;
    double _enteredAmount = double.parse(_amountController.text);
    if (_enteredTitle.isEmpty || _enteredAmount <= 0 || _currentdate == null)
      return;
    widget.addtransaction(_enteredTitle, _enteredAmount, _currentdate);

    Navigator.of(context).pop();
  }

  void _showcalender() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
        .then((selectedDate) {
      setState(() {
        _currentdate = selectedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.fromLTRB(
                10, 10, 10, MediaQuery.of(context).viewInsets.bottom + 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                  onSubmitted: (_) {
                    _submitdata();
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) {
                    _submitdata();
                  },
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: Text(_currentdate == null
                            ? "No date chosen"
                            : 'Picked Date: ${DateFormat.yMd().format(_currentdate)}'),
                      ),
                      TextButton(
                        onPressed: _showcalender,
                        child: Text(
                          "Choose a date",
                          style: TextStyle(
                              backgroundColor: Colors.white,
                              color: Theme.of(context).primaryColor),
                          // TextStyle(
                          //     color: Theme.of(context).primaryColorDark,
                          //     fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: _submitdata,
                  child: Text('Add Item',
                      style: Theme.of(context).textTheme.button),
                ),
              ],
            )),
      ),
    );
  }
}
