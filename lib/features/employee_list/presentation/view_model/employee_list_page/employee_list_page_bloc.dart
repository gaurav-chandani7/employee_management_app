import 'package:employee_management_app/core/constants/constants.dart';
import 'package:employee_management_app/features/employee_list/domain/entities/entities.dart';
import 'package:employee_management_app/features/employee_list/domain/usecases/usecases.dart';
import 'package:employee_management_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'employee_list_page_event.dart';
part 'employee_list_page_state.dart';

class EmployeeListPageBloc
    extends Bloc<EmployeeListPageEvent, EmployeeListPageState> {
  EmployeeListPageBloc(
      this._getEmployeeListUseCase, this._deleteEmployeeUseCase)
      : super(EmployeeListPageInitial()) {
    on<FetchEmployeeList>((event, emit) async {
      emit(EmployeeListPageLoading());
      var list = await _getEmployeeListUseCase(null);
      DateTime now = DateTime.now();
      list.sort((a, b) {
        if (b.startDate.compareTo(a.startDate) == 0) {
          // In case of same start date, comparing with end date
          return (b.endDate ?? now).compareTo(a.endDate ?? now);
        }
        //Latest date will appear first
        return b.startDate.compareTo(a.startDate);
      });
      emit(EmployeeListPageSuccess(data: list));
    });

    on<NavigateToAddEmployeeScreen>((event, emit) async {
      var pageRes =
          await Navigator.of(event.context).pushNamed(Routes.addEmployee.path);
      if (pageRes == true) {
        //Refresh data after new entry is added
        add(FetchEmployeeList());
      }
    });

    on<DeleteEmployeeRecordEvent>((event, emit) async {
      await _deleteEmployeeUseCase(event.id);
      //Refresh data after entry is deleted
      add(FetchEmployeeList());
    });

    on<NavigateToEditEmployeeScreen>((event, emit) async {
      var pageRes = await Navigator.of(event.context)
          .pushNamed(Routes.editEmployee.path, arguments: event.employeeItem);
      if (pageRes == true) {
        //Refresh data after record is updated
        add(FetchEmployeeList());
      }
    });

    on<ItemDismissedEvent>((event, emit) {
      state.data?.remove(event.item);
      emit(EmployeeListPageSuccess(data: state.data));
      event.context
          .showToast(
        message: "Employee data has been deleted",
        actionName: "Undo",
      )
          .then((value) {
        if (value == SnackBarClosedReason.action) {
          //Don't delete from db
          add(FetchEmployeeList());
        } else {
          add(DeleteEmployeeRecordEvent(id: event.item.id));
        }
      });
    });
  }

  final GetEmployeeListUseCase _getEmployeeListUseCase;
  final DeleteEmployeeUseCase _deleteEmployeeUseCase;
}
