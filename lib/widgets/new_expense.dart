
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:untitled1/model/expense.dart';

class NewExpense extends StatefulWidget{
  const NewExpense ({super.key ,required  this.onAddExpense} );

  final void Function (Expense expense) onAddExpense;

  @override
  State<NewExpense> createState(){
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense>{
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async{
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    //wait for this line
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData(){
    // tryParse('hello') => null
    // tryParse('1.12') => 1.12
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty || amountIsInvalid || _selectedDate == null){
      showDialog(context: context, builder: (ctx) => AlertDialog(
        title: Text('Invalid input'),
          content: Text('please make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(ctx);
            }, child: Text('okey'), )
          ],
        ),
      );
      return ;
    }
    widget.onAddExpense(Expense(title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory)
    );
    Navigator.pop(context);
  }


  //dis method should called after controller because if it is not the text or..
  // will stay in the memory even if the widget is not using or there and case crash
  @override
  void dispose() {
    //only "State" classes can implement this "dispose" method
    //(StatelessWidget cant) that s also why you must use a StatefulWidget here
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: double.infinity,
      child : SingleChildScrollView(
      child : Padding(
      padding: EdgeInsets.fromLTRB(16,16,16,keyboardSpace + 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(
                label: Text('Title')
            ), //to add lable
          ),
          Row(
            children: [
              Expanded(child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixText: '\$ ',
                      label:Text('Amount')
                  ),
                ),
              ),
              const SizedBox(width: 16),
              //row in row cause problems so it has to add expanded before the inner row
              Expanded(child:Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(_selectedDate == null ? 'No date selected' : formatter.format(_selectedDate!),),
                  IconButton(onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month))
                ],
              ),
              )
            ],
          ),
          const SizedBox(height: 16,),
          Row(children: [
            DropdownButton(
                value: _selectedCategory,
                items: Category.values.map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child:Text(category.name.toUpperCase()),),
                ).toList(),
                onChanged: (value){
                  if(value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                }),
            const Spacer(),
            ElevatedButton(onPressed: (){
              _submitExpenseData();

            },
                child: Text('save title')),
            TextButton(onPressed: (){
              Navigator.pop(context);
            },
                child: Text('Cancel'))
          ],
          ),
        ],
      ),
    )
    )
    );
  }
}