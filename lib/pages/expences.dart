import 'package:expence_tracker_app/widgets/expences_list.dart';
import 'package:flutter/material.dart';
import 'package:expence_tracker_app/models/expence.dart';

class Expences extends StatefulWidget {
  const Expences({Key? key}) : super(key: key);

  @override
  _ExpencesState createState() => _ExpencesState();
}

class _ExpencesState extends State<Expences> {
  // Create dummy data of expenses
  final List<ExpenceModel> _expenseList = [
    ExpenceModel(
        title: "Pepper",
        amount: 10,
        date: DateTime.now(),
        category: Category.food),
    ExpenceModel(
        title: "Tomato",
        amount: 12.5,
        date: DateTime.now(),
        category: Category.travel)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text("The chart"), // You can add your chart widget here
          // Display the expense list
          ExpenccesList(expenseList: _expenseList)
        ],
      ),
    );
  }
}
