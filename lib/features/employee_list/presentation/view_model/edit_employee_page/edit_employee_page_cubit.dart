import 'package:employee_management_app/features/employee_list/domain/entities/edit_employee_params.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:employee_management_app/features/employee_list/domain/usecases/edit_employee.dart';
import 'package:meta/meta.dart';

part 'edit_employee_page_state.dart';

class EditEmployeePageCubit extends Cubit<EditEmployeePageState> {
  EditEmployeePageCubit(this._editEmployeeUseCase)
      : super(EditEmployeePageInitial());

  showSelectRoleDialog() {
    emit(ShowRoleDialogEditPage());
  }

  showStartDateDialog() {
    emit(ShowStartDateDialogEditPage());
  }

  showConfirmDeleteDialog() {
    emit(ShowConfirmDeleteDialogEditPage());
  }

  editOperation(EditEmployeeParams editEmployeeParams) async {
    emit(EditEmployeePageLoading());
    await _editEmployeeUseCase(editEmployeeParams);
    emit(EditEmployeePageSuccess());
  }

  final EditEmployeeUseCase _editEmployeeUseCase;
}
