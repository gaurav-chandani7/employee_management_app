part of 'add_employee_page_cubit.dart';

@immutable
sealed class AddEmployeePageState {}

final class AddEmployeePageInitial extends AddEmployeePageState {}

final class AddEmployeePageLoading extends AddEmployeePageState {}

final class AddEmployeePageSuccess extends AddEmployeePageState {}

final class ShowSelectRoleDialog extends AddEmployeePageInitial {}

final class ShowStartDateDialog extends AddEmployeePageInitial {}
