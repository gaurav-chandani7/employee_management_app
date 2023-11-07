import 'package:employee_management_app/features/employee_list/domain/usecases/edit_employee.dart';
import 'package:employee_management_app/features/employee_list/employee_list.dart';
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
  sl.registerFactory(() => EditEmployeeUseCase(sl()));
}

void _bloc() {
  sl.registerFactory(() => EmployeeListPageBloc(sl(), sl()));
  sl.registerFactory(() => AddEmployeePageCubit(sl()));
  sl.registerFactory(() => EditEmployeePageCubit(sl()));
}
