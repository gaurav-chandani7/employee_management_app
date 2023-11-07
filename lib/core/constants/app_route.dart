import 'package:employee_management_app/features/employee_list/presentation/pages/pages.dart';
import 'package:flutter/material.dart';

enum Routes {
  root("/"),
  addEmployee("/addEmployee");

  final String path;
  const Routes(this.path);
}

Map<String, WidgetBuilder> appRoutes = {
  Routes.root.path: (context) => const EmployeeListScreen(),
  Routes.addEmployee.path: (context) => const AddEmployeeScreen()
};
