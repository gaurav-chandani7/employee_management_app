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
    return Container(
      color: toolbarSecondaryColor,
      child: SafeArea(
        bottom: false,
        child: MaterialApp(
            title: 'Employee Management app',
            routes: appRoutes,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: primaryColor,
                  primary: primaryColor,
                  secondary: toolbarSecondaryColor,
                ),
                appBarTheme: const AppBarTheme(
                    backgroundColor: primaryColor,
                    centerTitle: false,
                    actionsIconTheme: IconThemeData(color: whiteColor),
                    titleTextStyle: TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18)),
                scaffoldBackgroundColor: whiteColor,
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                    elevation: 0,
                    foregroundColor: whiteColor,
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)))),
                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: buttonBackgroundColor,
                        foregroundColor: primaryColor,
                        elevation: 0,
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)))),
                iconTheme: const IconThemeData(color: primaryColor),
                bottomSheetTheme: const BottomSheetThemeData(
                    backgroundColor: whiteColor,
                    modalBackgroundColor: whiteColor,
                    modalBarrierColor: barrierColor),
                inputDecorationTheme: const InputDecorationTheme(
                    contentPadding: EdgeInsets.zero,
                    hintStyle: TextStyle(
                      color: tertiaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: textFieldBorderColor),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: textFieldBorderColor),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(4)))),
                dialogTheme: const DialogTheme(
                    backgroundColor: Colors.white,
                    surfaceTintColor: Colors.white),
                useMaterial3: true,
                primaryColor: primaryColor,
                textTheme: const TextTheme(
                    titleMedium: TextStyle(
                        color: textFieldColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)))),
      ),
    );
  }
}
