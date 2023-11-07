import 'package:hive/hive.dart';

part 'employee_item_hive.g.dart';

@HiveType(typeId: 1)
class EmployeeItemHiveModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  EmployeeRoleHive role;

  @HiveField(2)
  DateTime startDate;

  @HiveField(3)
  DateTime? endDate;
  EmployeeItemHiveModel(
      {required this.name,
      required this.role,
      required this.startDate,
      this.endDate});
}

@HiveType(typeId: 2)
enum EmployeeRoleHive {
  @HiveField(0)
  productDesigner,
  @HiveField(1)
  flutterDeveloper,
  @HiveField(2)
  qaTester,
  @HiveField(3)
  productOwner
}
