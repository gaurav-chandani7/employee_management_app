import 'package:employee_management_app/features/employee_list/domain/entities/edit_employee_params.dart';
import 'package:employee_management_app/features/employee_list/domain/usecases/usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'edit_employee_page_state.dart';

class EditEmployeePageCubit extends Cubit<EditEmployeePageState> {
  EditEmployeePageCubit(this._editEmployeeUseCase, this._deleteEmployeeUseCase)
      : super(EditEmployeePageInitial());

  showSelectRoleDialog() {
    emit(ShowRoleDialogEditPage());
  }

  showStartDateDialog() {
    emit(ShowStartDateDialogEditPage());
  }

  showEndDateDialog() {
    emit(ShowEndDateDialogEditPage());
  }

  showConfirmDeleteDialog() {
    emit(ShowConfirmDeleteDialogEditPage());
  }

  editOperation(EditEmployeeParams editEmployeeParams) async {
    emit(EditEmployeePageLoading());
    await _editEmployeeUseCase(editEmployeeParams);
    emit(EditEmployeePageSuccess());
  }

  Future deleteOperation(int id) async {
    emit(EditEmployeePageLoading());
    await _deleteEmployeeUseCase(id);
    emit(EditEmployeePageSuccess());
    //Success state will tell UI to navigate back and update prev page
  }

  final EditEmployeeUseCase _editEmployeeUseCase;
  final DeleteEmployeeUseCase _deleteEmployeeUseCase;
}
