part of 'employee_list_page_bloc.dart';

@immutable
sealed class EmployeeListPageEvent {}

class FetchEmployeeList extends EmployeeListPageEvent {}

class NavigateToAddEmployeeScreen extends EmployeeListPageEvent {
  final BuildContext context;

  NavigateToAddEmployeeScreen({required this.context});
}

class DeleteEmployeeRecordEvent extends EmployeeListPageEvent {
  final int id;

  DeleteEmployeeRecordEvent({required this.id});
}

class NavigateToEditEmployeeScreen extends EmployeeListPageEvent {
  final BuildContext context;
  final EmployeeItemEntity employeeItem;

  NavigateToEditEmployeeScreen(
      {required this.context, required this.employeeItem});
}
