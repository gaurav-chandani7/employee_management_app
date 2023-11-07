part of 'employee_list_page_bloc.dart';

@immutable
sealed class EmployeeListPageState {
  final List<EmployeeItemEntity>? data;
  const EmployeeListPageState({this.data});
}

final class EmployeeListPageInitial extends EmployeeListPageState {}

final class EmployeeListPageLoading extends EmployeeListPageState {}

final class EmployeeListPageSuccess extends EmployeeListPageState {
  const EmployeeListPageSuccess({required super.data});
}

final class EmployeeListPageFailure extends EmployeeListPageState {}
