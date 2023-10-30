import 'package:expence_tracker_app/models/expence.dart';
import 'package:flutter/material.dart';

class ExpenccesList extends StatelessWidget {
  const ExpenccesList({super.key, required this.expenseList});

  final List<ExpenceModel> expenseList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: expenseList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(expenseList[index].title),
            subtitle: Text(
                'Amount: \$${expenseList[index].amount.toStringAsFixed(2)}'),
                
          );

        },
      ),
    );
  }
}
