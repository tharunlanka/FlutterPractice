import 'package:flutter/material.dart';
import 'package:flutter_practice/models/ListTranscations.dart';
import 'package:flutter_practice/utilities/database_helper.dart';
import 'package:intl/intl.dart';
import 'ElevatedButtonWidget.dart';

class NewTransactionWidget extends StatefulWidget {
  final Function addTx;

  const NewTransactionWidget(this.addTx, {super.key});

  @override
  State<NewTransactionWidget> createState() => _NewTransactionWidget();
}

class _NewTransactionWidget extends State<NewTransactionWidget> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  final DatabaseHelper _databaseHelper= DatabaseHelper.instance;

  Future<void> _submitData() async {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
   var result= await _databaseHelper.insertList(ListTranscations(id:"0", title: enteredTitle, amount: enteredAmount, date: _selectedDate));
   if(result!=0){
     // successfully inserted data into database
   }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: ConstrainedBox(
        constraints: const BoxConstraints(),
    child:Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                  hintText: 'Enter Title',
                ),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                  hintText: 'Enter Amount',
                ),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
            ),
            ElevatedButton(
              onPressed: _presentDatePicker,
              child: Text(
                _selectedDate == null
                    ? 'No Date Chosen!'
                    : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}',
              ),
            ),
            ElevatedButtonWidget(
              textData: 'Add',
              onPressed: _submitData,
            )
          ],
        ),
      ),
    ),
    ),
    );
  }
}
