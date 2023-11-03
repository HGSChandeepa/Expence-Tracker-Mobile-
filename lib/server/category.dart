import 'package:expence_tracker_app/models/expence.dart';
import 'package:hive/hive.dart';

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 2; // Choose a unique typeId for your enum

  @override
  Category read(BinaryReader reader) {
    return Category.values[reader.readByte()];
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    writer.writeByte(obj.index);
  }
}
