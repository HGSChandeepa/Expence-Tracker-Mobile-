import 'package:uuid/uuid.dart';

//create a uuid
final uuid = const Uuid().v4();

//enum for categories

enum Category { food, travel, leasure, work }

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
}
