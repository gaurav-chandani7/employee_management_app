import 'package:employee_management_app/features/employee_list/domain/entities/entities.dart';

class AddEmployeeParams {
  String? employeeName;
  EmployeeRole? role;
  DateTime? startDate;
  DateTime? endDate;
  AddEmployeeParams({
    this.employeeName,
    this.role,
    this.startDate,
    this.endDate,
  });
  factory AddEmployeeParams.initial() => AddEmployeeParams();

  @override
  String toString() {
    return 'AddEmployeeParams(employeeName: $employeeName, role: $role, startDate: $startDate, endDate: $endDate)';
  }
}
