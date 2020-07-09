// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shiftCard.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShiftCardAdapter extends TypeAdapter<ShiftCard> {
  @override
  final typeId = 2;

  @override
  ShiftCard read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShiftCard(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ShiftCard obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.start)
      ..writeByte(2)
      ..write(obj.end)
      ..writeByte(3)
      ..write(obj.length);
  }
}
