import 'package:expence_tracker_app/server/database.dart';
import 'package:expence_tracker_app/widgets/add_expence.dart';
import 'package:expence_tracker_app/widgets/expences_list.dart';
import 'package:flutter/material.dart';
import 'package:expence_tracker_app/models/expence.dart';
import 'package:hive/hive.dart';
import 'package:pie_chart/pie_chart.dart';

class Expences extends StatefulWidget {
  const Expences({Key? key}) : super(key: key);

  @override
  _ExpencesState createState() => _ExpencesState();
}

class _ExpencesState extends State<Expences> {
  //hive related stuff
  final _myBox = Hive.box("expenceDatabase");
  Database db = Database();

  // final List<ExpenceModel> _expenseList = [
  //   ExpenceModel(
  //       title: "Pepper",
  //       amount: 10,
  //       date: DateTime.now(),
  //       category: Category.food),
  //   ExpenceModel(
  //       title: "Tomato",
  //       amount: 12.5,
  //       date: DateTime.now(),
  //       category: Category.travel)
  // ];

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
    setState(() {
      db.expenceList.add(expence);
      calculateCategoryAmounts();
    });

    db.updateData();
  }

  void removeExpence(ExpenceModel expence) {
    final deletedIndex = db.expenceList.indexOf(expence);
    ExpenceModel deletingExpende = expence;
    setState(() {
      db.expenceList.remove(deletingExpende);
      calculateCategoryAmounts();
    });
    db.updateData();

    //this will help to remove multiplles
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 2000),
        content: const Text("Expencce Deleted"),
        action: SnackBarAction(
          label: "undo",
          onPressed: () {
            setState(() {
              db.expenceList.insert(deletedIndex, deletingExpende);
            });
            calculateCategoryAmounts();
          },
        ),
      ),
    );
  }

// PIE CHART

  double foodVal = 0;
  double travelVal = 0;
  double leasureVal = 0;
  double workVal = 0;

  void calculateCategoryAmounts() {
    double foodTotal = 0;
    double travelTotal = 0;
    double leasureTotal = 0;
    double workTotal = 0;

    for (final expence in db.expenceList) {
      if (expence.category == Category.food) {
        foodTotal += expence.amount;
      }
      if (expence.category == Category.leasure) {
        leasureTotal += expence.amount;
      }
      if (expence.category == Category.travel) {
        travelTotal += expence.amount;
      }
      if (expence.category == Category.work) {
        workTotal += expence.amount;
      }
    }

    setState(() {
      foodVal = foodTotal;
      leasureVal = leasureTotal;
      travelVal = travelTotal;
      workVal = workTotal;

      // Update the dataMap with the calculated values
      dataMap = {
        "Food": foodVal,
        "Travel": travelVal,
        "Leasure": leasureVal,
        "Work": workVal,
      };
    });
  }

// Initialize dataMap with the initial values
  Map<String, double> dataMap = {
    "Food": 0,
    "Travel": 0,
    "Leasure": 0,
    "Work": 0,
  };

  @override
  void initState() {
    super.initState();

    //hive stuff for init state

    //if this is the first time create the initial data
    if (_myBox.get("EXP_DATA") == null) {
      db.createInitialData();
      calculateCategoryAmounts();
    } else {
      db.loadData();
      calculateCategoryAmounts();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent =
        const Center(child: Text("No data found please add some!"));

    if (db.expenceList.isNotEmpty) {
      mainContent = ExpenccesList(
        expenseList: db.expenceList,
        onDeleteExpence: removeExpence,
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 81, 255),
        title: const Text("Expence Tracker"),
        elevation: 0,
        actions: [
          Container(
            color: Colors.yellow,
            child: IconButton(
              onPressed: _openAddExpencesverlay,
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PieChart(
            animationDuration: const Duration(milliseconds: 800),
            chartLegendSpacing: 32,
            centerText: "Expences",
            dataMap: dataMap,
          ),
          mainContent
        ],
      ),
    );
  }
}
