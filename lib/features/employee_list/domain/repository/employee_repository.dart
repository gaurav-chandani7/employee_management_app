import 'package:employee_management_app/features/employee_list/domain/entities/edit_employee_params.dart';
import 'package:employee_management_app/features/employee_list/domain/entities/entities.dart';

abstract class EmployeeRepository {
  Future<List<EmployeeItemEntity>> getEmployeeList();
  Future<bool> addEmployee(AddEmployeeParams employeeItem);
  Future<void> deleteEmployee(int id);
  Future<void> updateEmployee(EditEmployeeParams editEmployeeParams);
}
