import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

//create a uuid
final uuid = const Uuid().v4();

//date formater
final formatedDate = DateFormat.yMd();

//enum for categories
enum Category { food, travel, leasure, work }

//category icons
final CategoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.travel_explore,
  Category.leasure: Icons.leave_bags_at_home_rounded,
  Category.work: Icons.work,
};

class ExpenceModel {
  ExpenceModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid;

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  //getFrmated date
  String get formattdeDateValue {
    return formatedDate.format(date);
  }
}
