part of 'edit_employee_page_cubit.dart';

@immutable
sealed class EditEmployeePageState {}

final class EditEmployeePageInitial extends EditEmployeePageState {}

final class EditEmployeePageLoading extends EditEmployeePageState {}

final class EditEmployeePageSuccess extends EditEmployeePageState {}

final class ShowRoleDialogEditPage extends EditEmployeePageInitial {}

final class ShowStartDateDialogEditPage extends EditEmployeePageInitial {}

final class ShowConfirmDeleteDialogEditPage extends EditEmployeePageInitial {}
