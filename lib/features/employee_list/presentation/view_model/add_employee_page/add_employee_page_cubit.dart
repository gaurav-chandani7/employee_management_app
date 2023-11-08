import 'package:employee_management_app/features/employee_list/domain/entities/entities.dart';
import 'package:employee_management_app/features/employee_list/domain/usecases/usecases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_employee_page_state.dart';

class AddEmployeePageCubit extends Cubit<AddEmployeePageState> {
  AddEmployeePageCubit(this._addEmployeeUseCase)
      : super(AddEmployeePageInitial());
  final AddEmployeeUseCase _addEmployeeUseCase;

  addEmployeeOperation(AddEmployeeParams addEmployeeParams) async {
    emit(AddEmployeePageLoading());
    var res = await _addEmployeeUseCase(addEmployeeParams);
    if (res) {
      emit(AddEmployeePageSuccess());
    }
  }

  showSelectRoleDialog() {
    emit(ShowSelectRoleDialog());
  }

  showStartDateDialog() {
    emit(ShowStartDateDialog());
  }

  showEndDateDialog() {
    emit(ShowEndDateDialog());
  }
}
