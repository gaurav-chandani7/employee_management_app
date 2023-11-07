import 'dart:developer';

import 'package:employee_management_app/features/employee_list/domain/entities/add_employee_params.dart';
import 'package:employee_management_app/features/employee_list/domain/usecases/usecases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_employee_page_state.dart';

class AddEmployeePageCubit extends Cubit<AddEmployeePageState> {
  AddEmployeePageCubit(this._addEmployeeUseCase)
      : super(AddEmployeePageInitial());
  final AddEmployeeUseCase _addEmployeeUseCase;

  addEmployeeOperation(
      {required BuildContext context,
      required AddEmployeeParams addEmployeeParams}) async {
    log(addEmployeeParams.toString());
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
}
