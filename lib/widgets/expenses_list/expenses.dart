
import 'package:flutter/material.dart';
import 'package:untitled1/widgets/expenses_list.dart';
import 'package:untitled1/model/expense.dart';
import 'package:untitled1/widgets/new_expense.dart';
import 'package:untitled1/widgets/chart/chart.dart';
import 'package:untitled1/widgets/chart/chart_bar.dart';
//import 'package:flutter/material.dart.dart';

class Expenses extends StatefulWidget {

  const Expenses ( {super.key});


  @override
  State<Expenses> createState(){
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registerExpenses = [
    Expense(title : 'flutter Course1' , amount : 19.99 , date : DateTime.now()
    , category: Category.work),
    Expense(title : 'flutter Course2' , amount : 20.99 , date : DateTime.now()
        , category: Category.food),
    Expense(title : 'flutter Course3' , amount : 21.99 , date : DateTime.now()
        , category: Category.leisure),
    Expense(title : 'flutter Course4' , amount : 22.99 , date : DateTime.now()
        , category: Category.travel),
    Expense(title : 'flutter Course1' , amount : 19.99 , date : DateTime.now()
        , category: Category.work),
    Expense(title : 'flutter Course2' , amount : 20.99 , date : DateTime.now()
        , category: Category.food),
    Expense(title : 'flutter Course3' , amount : 21.99 , date : DateTime.now()
        , category: Category.leisure),
    Expense(title : 'flutter Course4' , amount : 22.99 , date : DateTime.now()
        , category: Category.travel),
  ];

  void _openAddExpenseOverlay(){
    //ctx:this is now the context object for the modal element that created by flutter
    showModalBottomSheet(
      useSafeArea: true,
      //make to page full screen
      isScrollControlled: true,
      context: context,
      builder: (ctx) =>  NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense){
    setState(() {
      _registerExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense){
    final expenseIndex = _registerExpenses.indexOf(expense);
    setState(() {
      _registerExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: Duration(seconds: 3),
          content: Text('Expense deleted.'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: (){
              setState(() {
                _registerExpenses.insert(expenseIndex, expense);
              });
            },
          ),
      ),
    );
  }

  @override
  Widget build (BuildContext context){
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );
    if(_registerExpenses.isNotEmpty){
      mainContent = ExpensesList(expenses: _registerExpenses ,
        onRemoveExpense: _removeExpense,);
    }
     return Scaffold(
       appBar: AppBar(
         title: const Text('Flutter ExpenseTracker'),
         actions: [
           IconButton(
               onPressed: _openAddExpenseOverlay ,
               icon: Icon(Icons.add),
               color: Color.fromARGB(255,255,255,255),
           )
         ],
       ),
       body:width < 600 ? Column(
        children: [
          Chart(expenses : _registerExpenses ),
          Expanded(child : mainContent,)
        ]   ,
     ) : Row (
        children: [Expanded(child:
                    Chart(expenses : _registerExpenses ),
              ),
             Expanded(child : mainContent,
             )
           ]

       ),
     );
  }
}


