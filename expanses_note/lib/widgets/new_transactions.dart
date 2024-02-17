import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function addTransactions;

  NewTransactions(this.addTransactions) {
    print('Contructor NewTransactions Widget');
  }

  @override
  State<NewTransactions> createState() {
    print('createState NewTransactions Widget');
    return _NewTransactionsState();
  }
}

class _NewTransactionsState extends State<NewTransactions> {
  //Take text from input fields
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  _NewTransactionsState() {
    print('Constructor _NewTransactionsState');
  }

  @override
  void initState() {
    print('initState()');
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NewTransactions oldWidget) {
    print('didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('dispose()');
    super.dispose();
  }

  void _submittedData() {
    if (_amountController.text.isEmpty || _titleController.text.isEmpty) return;
    final String enteredTitle =
        _titleController.text.split(' ')[0][0].toUpperCase().toString() +
            _titleController.text.substring(1);
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null)
      return;

    //widget. --- use parent class methods
    widget.addTransactions(enteredTitle, enteredAmount, _selectedDate);

    //Hide the bottom sheet as user submit the data
    Navigator.of(context).pop();
  }

  void _presentPickedDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                // autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                controller: _titleController,
                onSubmitted: (_) => _submittedData(),
                // onChanged: (value) => {titleInput = value},
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                onSubmitted: (_) => _submittedData(),
                keyboardType:
                    TextInputType.number, //set the number type keyboard
                // onChanged: (value) => {amountInput = value},
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Choosen!'
                          : 'Date: ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                  TextButton(
                    onPressed: _presentPickedDate,
                    child: Text(
                      'Select Date',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: _submittedData,
                child: Text(
                  'Add Transaction',
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
