// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_item_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmployeeItemHiveModelAdapter extends TypeAdapter<EmployeeItemHiveModel> {
  @override
  final int typeId = 1;

  @override
  EmployeeItemHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmployeeItemHiveModel(
      name: fields[0] as String,
      role: fields[1] as EmployeeRoleHive,
      startDate: fields[2] as DateTime,
      endDate: fields[3] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, EmployeeItemHiveModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.role)
      ..writeByte(2)
      ..write(obj.startDate)
      ..writeByte(3)
      ..write(obj.endDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeItemHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EmployeeRoleHiveAdapter extends TypeAdapter<EmployeeRoleHive> {
  @override
  final int typeId = 2;

  @override
  EmployeeRoleHive read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return EmployeeRoleHive.productDesigner;
      case 1:
        return EmployeeRoleHive.flutterDeveloper;
      case 2:
        return EmployeeRoleHive.qaTester;
      case 3:
        return EmployeeRoleHive.productOwner;
      default:
        return EmployeeRoleHive.productDesigner;
    }
  }

  @override
  void write(BinaryWriter writer, EmployeeRoleHive obj) {
    switch (obj) {
      case EmployeeRoleHive.productDesigner:
        writer.writeByte(0);
        break;
      case EmployeeRoleHive.flutterDeveloper:
        writer.writeByte(1);
        break;
      case EmployeeRoleHive.qaTester:
        writer.writeByte(2);
        break;
      case EmployeeRoleHive.productOwner:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeRoleHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
