import 'package:employee_management_app/features/employee_list/data/data_sources/local/app_database.dart';
import 'package:employee_management_app/features/employee_list/data/models/hive/employee_item_hive.dart';
import 'package:employee_management_app/features/employee_list/domain/entities/add_employee_params.dart';
import 'package:employee_management_app/features/employee_list/domain/entities/employee_item.dart';
import 'package:employee_management_app/features/employee_list/domain/repository/repository.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final AppDatabase _appDatabase;

  EmployeeRepositoryImpl(this._appDatabase);
  @override
  Future<List<EmployeeItemEntity>> getEmployeeList() async {
    return _appDatabase.getEmployeeList();
  }

  @override
  Future<bool> addEmployee(AddEmployeeParams addEmployeeData) async {
    return await _appDatabase.addEmployee(EmployeeItemHiveModel(
            name: addEmployeeData.employeeName ?? "",
            role: addEmployeeData.role!.employeeRoleHive,
            startDate: addEmployeeData.startDate!,
            endDate: addEmployeeData.endDate)) >
        0;
  }

  @override
  Future<void> deleteEmployee(int id) {
    return _appDatabase.deleteEmployee(id);
  }
}

extension EmployeeRoleToHive on EmployeeRole {
  EmployeeRoleHive get employeeRoleHive {
    switch (this) {
      case EmployeeRole.productDesigner:
        return EmployeeRoleHive.productDesigner;
      case EmployeeRole.flutterDeveloper:
        return EmployeeRoleHive.flutterDeveloper;
      case EmployeeRole.qaTester:
        return EmployeeRoleHive.qaTester;
      case EmployeeRole.productOwner:
        return EmployeeRoleHive.productOwner;
    }
  }
}
