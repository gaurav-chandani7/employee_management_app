import 'package:employee_management_app/features/employee_list/domain/entities/entities.dart';
import 'package:employee_management_app/features/employee_list/presentation/pages/edit_employee_screen.dart';
import 'package:employee_management_app/features/employee_list/presentation/pages/pages.dart';
import 'package:flutter/material.dart';

enum Routes {
  root("/"),
  addEmployee("/addEmployee"),
  editEmployee("/editEmployee");

  final String path;
  const Routes(this.path);
}

Map<String, WidgetBuilder> appRoutes = {
  Routes.root.path: (context) => const EmployeeListScreen(),
  Routes.addEmployee.path: (context) => const AddEmployeeScreen(),
  Routes.editEmployee.path: (context) => EditEmployeeScreen(
        employeeItem:
            ModalRoute.of(context)!.settings.arguments as EmployeeItemEntity,
      )
};
