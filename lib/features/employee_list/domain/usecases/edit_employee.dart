import 'package:employee_management_app/core/core.dart';
import 'package:employee_management_app/features/employee_list/domain/entities/edit_employee_params.dart';
import 'package:employee_management_app/features/employee_list/domain/repository/repository.dart';

class EditEmployeeUseCase extends UseCase<void, EditEmployeeParams> {
  final EmployeeRepository _repo;

  EditEmployeeUseCase(this._repo);
  @override
  Future<void> call(EditEmployeeParams params) => _repo.updateEmployee(params);
}
