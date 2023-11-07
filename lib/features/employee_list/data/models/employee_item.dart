import 'package:employee_management_app/features/employee_list/data/models/hive/employee_item_hive.dart';
import 'package:employee_management_app/features/employee_list/domain/entities/entities.dart';

class EmployeeItemModel extends EmployeeItemEntity {
  EmployeeItemModel(
      {required super.id,
      required super.name,
      required super.role,
      required super.startDate,
      super.endDate});
  factory EmployeeItemModel.fromHiveModel(
          EmployeeItemHiveModel employeeItemHiveModel) =>
      EmployeeItemModel(
          id: employeeItemHiveModel.key,
          name: employeeItemHiveModel.name,
          role: employeeItemHiveModel.role.employeeRole,
          startDate: employeeItemHiveModel.startDate,
          endDate: employeeItemHiveModel.endDate);
}

extension on EmployeeRoleHive {
  EmployeeRole get employeeRole {
    switch (this) {
      case EmployeeRoleHive.productDesigner:
        return EmployeeRole.productDesigner;
      case EmployeeRoleHive.flutterDeveloper:
        return EmployeeRole.flutterDeveloper;
      case EmployeeRoleHive.qaTester:
        return EmployeeRole.qaTester;
      case EmployeeRoleHive.productOwner:
        return EmployeeRole.productOwner;
    }
  }
}
