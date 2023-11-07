import 'package:employee_management_app/core/usecase/usecase.dart';
import 'package:employee_management_app/features/employee_list/domain/entities/entities.dart';
import 'package:employee_management_app/features/employee_list/domain/repository/repository.dart';

class AddEmployeeUseCase extends UseCase<bool, AddEmployeeParams> {
  final EmployeeRepository _repo;

  AddEmployeeUseCase(this._repo);
  @override
  Future<bool> call(AddEmployeeParams params) async =>
      _repo.addEmployee(params);
}
