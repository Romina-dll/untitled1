
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid =  Uuid(); // const used for reuse this any where else
final formatter = DateFormat.yMd(); //yMd difine how the date will formatted

enum Category {
  food ,
  travel ,
  leisure,
  work
}

const categoryItem = {
  Category.food : Icons.lunch_dining,
  Category.travel : Icons.flight_takeoff,
  Category.leisure : Icons.movie,
  Category.work : Icons.work
};

class Expense {
  final String id;
  final String title;
  final double amount ;
  final DateTime date;
  final Category category;

  Expense({
    required this.title ,
    required this.amount ,
    required this.date,
    required this.category,
  }): id = uuid.v4(); //generate uniq id

  String get formattedDate{
    return formatter.format(date);
  }

}

class ExpenseBucket {

  ExpenseBucket({required this.category ,required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses , this.category)
      : expenses = allExpenses.where((expense) => expense.category == category).toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses{
    double sum = 0 ;

    for (final expense in expenses){
      sum += expense.amount;
    }

    return sum;
  }
}