// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expence.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenceModelAdapter extends TypeAdapter<ExpenceModel> {
  @override
  final int typeId = 1;

  @override
  ExpenceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenceModel(
      id: fields[0] as String,
      title: fields[1] as String,
      decsription: fields[2] as String,
      date: fields[3] as DateTime,
      category: fields[4] as Category,
    );
  }

  @override
  void write(BinaryWriter writer, ExpenceModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.decsription)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
