import 'package:employee_management_app/core/usecase/usecase.dart';
import 'package:employee_management_app/features/employee_list/domain/entities/entities.dart';
import 'package:employee_management_app/features/employee_list/domain/repository/repository.dart';

class GetEmployeeListUseCase
    implements UseCase<List<EmployeeItemEntity>, void> {
  final EmployeeRepository _repo;

  GetEmployeeListUseCase(this._repo);
  @override
  Future<List<EmployeeItemEntity>> call(void params) => _repo.getEmployeeList();
}
