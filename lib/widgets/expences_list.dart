import 'package:expence_tracker_app/models/expence.dart';
import 'package:expence_tracker_app/widgets/expence_tile.dart';
import 'package:flutter/material.dart';

class ExpenccesList extends StatelessWidget {
  final void Function(ExpenceModel expence) onDeleteExpence;
  final void Function(ExpenceModel expence) onEditExpence;
  const ExpenccesList(
      {super.key,
      required this.expenseList,
      required this.onDeleteExpence,
      required this.onEditExpence});

  final List<ExpenceModel> expenseList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: expenseList.length,
          itemBuilder: (context, index) {
            return Dismissible(
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) {
                onDeleteExpence(expenseList[index]);
              },
              key: ValueKey(expenseList[index]),
              child: InkWell(
                onTap: () {
                  onEditExpence(expenseList[index]);
                },
                child: ExpenceItem(
                  expence: expenseList[index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
