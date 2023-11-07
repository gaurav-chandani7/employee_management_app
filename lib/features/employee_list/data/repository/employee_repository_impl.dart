import 'package:employee_management_app/features/employee_list/data/data.dart';
import 'package:employee_management_app/features/employee_list/domain/domain.dart';

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

  @override
  Future<void> updateEmployee(EditEmployeeParams editEmployeeParams) {
    return _appDatabase.updateEmployee(
        key: editEmployeeParams.id,
        employeeItemHiveModel: EmployeeItemHiveModel(
            name: editEmployeeParams.employeeName,
            role: editEmployeeParams.role.employeeRoleHive,
            startDate: editEmployeeParams.startDate,
            endDate: editEmployeeParams.endDate));
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
