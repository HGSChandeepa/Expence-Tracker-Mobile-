import 'package:expence_tracker_app/models/expence.dart';
import 'package:hive/hive.dart';

class Database {
  //create  the database reference
  final _myBox = Hive.box("expenceDatabase");

  List<ExpenceModel> expenceList = [];

  //create the init expence list function
  void createInitialData() {
    expenceList = [
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
  }

  //load the data
  void loadData() {
    final dynamic data = _myBox.get("EXP_DATA"); // Get the data as dynamic
    if (data != null && data is List<dynamic>) {
      // Check if the data is not null and is a List<dynamic>
      expenceList =
          data.cast<ExpenceModel>().toList(); // Cast it to List<ExpenceModel>
    }
  }

  // update the data
  Future<void> updateData() async {
    await _myBox.put("EXP_DATA", expenceList);

    print("saved data");
  }
}
