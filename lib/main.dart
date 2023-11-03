import 'package:expence_tracker_app/models/expence.dart';
import 'package:expence_tracker_app/pages/expences.dart';
import 'package:expence_tracker_app/server/category.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  //init hive
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenceModelAdapter());
  Hive.registerAdapter(CategoryAdapter());
  //open a hive box to store the  data
  await Hive.openBox("expenceDatabase");

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Expences());
  }
}
