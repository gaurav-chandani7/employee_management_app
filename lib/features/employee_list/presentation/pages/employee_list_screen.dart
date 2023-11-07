import 'package:employee_management_app/core/widgets/widgets.dart';
import 'package:employee_management_app/dependencies_injection.dart';
import 'package:employee_management_app/features/employee_list/presentation/view_model/view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  final bloc = sl<EmployeeListPageBloc>();
  @override
  void initState() {
    super.initState();
    bloc.add(FetchEmployeeList());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<EmployeeListPageBloc, EmployeeListPageState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is EmployeeListPageSuccess) {
            var data = state.data ?? [];
            return Parent(
              appBar: AppBar(
                title: const Text("Employee list"),
              ),
              floatingButton: FloatingActionButton(
                  onPressed: () =>
                      bloc.add(NavigateToAddEmployeeScreen(context: context))),
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key("${data[index].id}"),
                      onDismissed: (_) {
                        bloc.add(DeleteEmployeeRecordEvent(id: data[index].id));
                      },
                      background: Container(
                        color: Colors.red,
                      ),
                      child: ListTile(
                        title: Text(
                          data[index].name,
                        ),
                        subtitle: Text(data[index].role.roleDisplayName),
                      ),
                    );
                  }),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
