import 'package:collection/collection.dart';
import 'package:employee_management_app/core/constants/constants.dart';
import 'package:employee_management_app/core/widgets/widgets.dart';
import 'package:employee_management_app/dependencies_injection.dart';
import 'package:employee_management_app/features/employee_list/domain/entities/entities.dart';
import 'package:employee_management_app/features/employee_list/presentation/view_model/view_model.dart';
import 'package:employee_management_app/utils/utils.dart';
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
                    onPressed: () => bloc
                        .add(NavigateToAddEmployeeScreen(context: context))),
                child: data.isEmpty ? _noRecordsUI() : _groupedList(data));
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _noRecordsUI() {
    return Container(
      color: noRecordsBackgroundColor,
      alignment: Alignment.center,
      child: Container(
          constraints: const BoxConstraints(maxWidth: 260),
          child: Image.asset(noRecordsImage)),
    );
  }

  Widget _groupedList(List<EmployeeItemEntity> data) {
    var groupedItems = groupBy(
        data,
        (e) => (e.endDate != null &&
            e.endDate!.difference(DateTime.now()).inDays < 1));
    return ListView.builder(
      itemCount: groupedItems.length,
      itemBuilder: (BuildContext context, int index) {
        bool category = groupedItems.keys.elementAt(index);
        String categoryName = groupedItems.keys.elementAt(index)
            ? "Previous Employees"
            : "Current Employees";
        List itemsInCategory = groupedItems[category]!;

        // Return a widget representing the category and its items
        return Column(
          children: [
            Text(categoryName,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: itemsInCategory.length,
              itemBuilder: (BuildContext context, int index) {
                EmployeeItemEntity item = itemsInCategory[index];
                // Return a widget representing the item
                return Dismissible(
                  key: Key("${item.id}"),
                  onDismissed: (_) {
                    bloc.add(DeleteEmployeeRecordEvent(id: item.id));
                  },
                  background: Container(
                    color: Colors.red,
                  ),
                  child: ListTile(
                    isThreeLine: true,
                    title: Text(
                      item.name,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.role.roleDisplayName),
                        Builder(builder: (context) {
                          var endDate = item.endDate;
                          String text = endDate != null
                              ? "${formatDate(item.startDate)} - ${formatDate(item.endDate!)}"
                              : "From ${formatDate(item.startDate)}";
                          return Text(text);
                        })
                      ],
                    ),
                    onTap: () => bloc.add(NavigateToEditEmployeeScreen(
                        context: context, employeeItem: item)),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
