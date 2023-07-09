

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/widgets/expenses_list/expense_item.dart';

import '../model/expense.dart';

//this is for showing the list of expenses so we use stateless
class ExpensesList extends StatelessWidget{
  const ExpensesList({
    super.key ,
    required this.expenses,
    required this.onRemoveExpense
  });

  final List<Expense> expenses;
  final void Function(Expense expense)onRemoveExpense;



  @override
  Widget build(BuildContext context){
    // it will create views only when they are visible
    return ListView.builder( itemCount: expenses.length
      ,itemBuilder: (ctx,index) => Dismissible(
          key: ValueKey(expenses[index]),
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin:EdgeInsets.symmetric(horizontal:Theme.of(context).cardTheme.margin!.horizontal),
          ),
          onDismissed:  (direction){
            onRemoveExpense(expenses[index]);
          },
          child: ExpenseItem(expenses[index])));
  }
}