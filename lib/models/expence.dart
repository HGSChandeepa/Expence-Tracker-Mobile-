import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

part 'expence.g.dart';

//create a uuid
final uuid = const Uuid().v4();

//date formater
final formatedDate = DateFormat.yMd();

//enum for categories
enum Category { lowest, low, high, highst }

//category icons
final CategoryIcons = {
  Category.lowest: Icons.lunch_dining,
  Category.low: Icons.travel_explore,
  Category.high: Icons.leave_bags_at_home_rounded,
  Category.highst: Icons.work,
};

@HiveType(typeId: 1)
class ExpenceModel {
  ExpenceModel({
    required this.id,
    required this.title,
    required this.decsription,
    required this.date,
    required this.category,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String decsription;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final Category category;

  //getFrmated date
  String get formattdeDateValue {
    return formatedDate.format(date);
  }

  //get the id of a expence
  // String get expenceId {
  //   return id;
  // }
}
