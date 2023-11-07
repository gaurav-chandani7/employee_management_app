import 'package:employee_management_app/features/employee_list/data/data_sources/local/app_database.dart';
import 'package:employee_management_app/features/employee_list/data/models/hive/employee_item_hive.dart';
import 'package:employee_management_app/features/employee_list/data/repository/employee_repository_impl.dart';
import 'package:employee_management_app/features/employee_list/domain/repository/repository.dart';
import 'package:employee_management_app/features/employee_list/domain/usecases/delete_employee.dart';
import 'package:employee_management_app/features/employee_list/domain/usecases/usecases.dart';
import 'package:employee_management_app/features/employee_list/presentation/bloc/add_employee_page/add_employee_page_cubit.dart';
import 'package:employee_management_app/features/employee_list/presentation/bloc/employee_list_page/employee_list_page_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

GetIt sl = GetIt.instance;

Future<void> serviceLocator() async {
  await _initialSetup();
  _dataSources();
  _repositories();
  _useCase();
  _bloc();
}

Future<void> _initialSetup() async {
  await Hive.initFlutter();
  Hive.registerAdapter(EmployeeItemHiveModelAdapter());
  Hive.registerAdapter(EmployeeRoleHiveAdapter());
  var box = await Hive.openBox<EmployeeItemHiveModel>("employeeList");
  // box.add(EmployeeItemHiveModel(
  //     name: "Gaurav Chandani",
  //     role: EmployeeRoleHive.flutterDeveloper,
  //     startDate: DateTime(2021, 7, 10)));
  sl.registerSingleton(box);
}

void _dataSources() {
  sl.registerLazySingleton<AppDatabase>(() => AppDatabaseImpl(sl()));
}

void _repositories() {
  sl.registerLazySingleton<EmployeeRepository>(
      () => EmployeeRepositoryImpl(sl()));
}

void _useCase() {
  sl.registerFactory(() => GetEmployeeListUseCase(sl()));
  sl.registerFactory(() => AddEmployeeUseCase(sl()));
  sl.registerFactory(() => DeleteEmployeeUseCase(sl()));
}

void _bloc() {
  sl.registerFactory(() => EmployeeListPageBloc(sl(), sl()));
  sl.registerFactory(() => AddEmployeePageCubit(sl()));
}
