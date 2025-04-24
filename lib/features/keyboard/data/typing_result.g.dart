// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typing_result.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TypingResultAdapter extends TypeAdapter<TypingResult> {
  @override
  final int typeId = 0;

  @override
  TypingResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TypingResult(
      wpm: fields[0] as double,
      timeStamp: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, TypingResult obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.wpm)
      ..writeByte(1)
      ..write(obj.timeStamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypingResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
