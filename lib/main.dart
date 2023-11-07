import 'package:employee_management_app/core/constants/app_route.dart';
import 'package:employee_management_app/core/constants/theme_constants.dart';
import 'package:employee_management_app/dependencies_injection.dart';
import 'package:flutter/material.dart';

void main() async {
  await serviceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Employee Management app',
        routes: appRoutes,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: primaryColor,
            primary: primaryColor,
            secondary: toolbarSecondaryColor,
          ),
          useMaterial3: true,
          primaryColor: primaryColor,
        ));
  }
}
