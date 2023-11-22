// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charts_setup.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChartsSetupAdapter extends TypeAdapter<ChartsSetup> {
  @override
  final int typeId = 1;

  @override
  ChartsSetup read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChartsSetup(
      fields[0] as String,
      (fields[1] as List)
          .map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList(),
      fields[2] as DateTime,
      fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ChartsSetup obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.chartSettings)
      ..writeByte(2)
      ..write(obj.modified)
      ..writeByte(3)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChartsSetupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
