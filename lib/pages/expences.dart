import 'package:expence_tracker_app/widgets/add_expence.dart';
import 'package:expence_tracker_app/widgets/expences_list.dart';
import 'package:flutter/material.dart';
import 'package:expence_tracker_app/models/expence.dart';

class Expences extends StatefulWidget {
  const Expences({Key? key}) : super(key: key);

  @override
  _ExpencesState createState() => _ExpencesState();
}

class _ExpencesState extends State<Expences> {
  final List<ExpenceModel> expenseList = [
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

  //show the bottoModelSheet

  void _openAddExpencesverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return AddNewExpencce(
          onAddExpence: addNewExpence,
        );
      },
    );
  }

  void addNewExpence(ExpenceModel expence) {
    expenseList.add(expence);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expence Tracker"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _openAddExpencesverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          const Text("The chart"),
          ExpenccesList(expenseList: expenseList)
        ],
      ),
    );
  }
}
