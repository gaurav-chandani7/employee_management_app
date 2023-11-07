import 'package:employee_management_app/core/usecase/usecase.dart';
import 'package:employee_management_app/features/employee_list/domain/repository/repository.dart';

class DeleteEmployeeUseCase extends UseCase<void, int> {
  final EmployeeRepository _repo;

  DeleteEmployeeUseCase(this._repo);
  @override
  Future<void> call(int params) => _repo.deleteEmployee(params);
}
