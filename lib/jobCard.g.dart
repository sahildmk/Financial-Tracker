// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobCard.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JobCardAdapter extends TypeAdapter<JobCard> {
  @override
  final typeId = 1;

  @override
  JobCard read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JobCard(
      fields[0] as String,
      fields[2] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, JobCard obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.rateOfPay)
      ..writeByte(1)
      ..write(obj.payFreq);
  }
}
