import 'package:employee_management_app/features/employee_list/data/models/models.dart';
import 'package:hive/hive.dart';

abstract class AppDatabase {
  List<EmployeeItemModel> getEmployeeList();
  Future<int> addEmployee(EmployeeItemHiveModel employeeItemHiveModel);
  Future<void> deleteEmployee(int id);
  Future updateEmployee(EmployeeItemHiveModel employeeItemHiveModel);
}

class AppDatabaseImpl implements AppDatabase {
  final Box<EmployeeItemHiveModel> _box;

  AppDatabaseImpl(this._box);

  @override
  List<EmployeeItemModel> getEmployeeList() =>
      _box.values.map((e) => EmployeeItemModel.fromHiveModel(e)).toList();

  @override
  Future<int> addEmployee(EmployeeItemHiveModel employeeItemHiveModel) {
    return _box.add(employeeItemHiveModel);
  }

  @override
  Future<void> deleteEmployee(int id) {
    return _box.delete(id);
  }

  @override
  Future updateEmployee(EmployeeItemHiveModel employeeItemHiveModel) {
    return _box.put(employeeItemHiveModel.key, employeeItemHiveModel);
  }
}
