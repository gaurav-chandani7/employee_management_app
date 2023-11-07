import 'package:employee_management_app/features/employee_list/domain/entities/entities.dart';

class EditEmployeeParams {
  int id;
  String employeeName;
  EmployeeRole role;
  DateTime startDate;
  DateTime? endDate;
  EditEmployeeParams({
    required this.id,
    required this.employeeName,
    required this.role,
    required this.startDate,
    this.endDate,
  });

  @override
  String toString() {
    return 'EditEmployeeParams(id: $id, employeeName: $employeeName, role: $role, startDate: $startDate, endDate: $endDate)';
  }
}
