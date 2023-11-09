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
                    child: const Icon(
                      Icons.add,
                      size: 26,
                    ),
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
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 76),
          child: ListView.builder(
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
                  Container(
                    constraints: const BoxConstraints(maxHeight: 56),
                    color: headerBackgroundColor,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerLeft,
                    child: Text(categoryName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: primaryColor,
                            fontSize: 16)),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: itemsInCategory.length,
                    itemBuilder: (BuildContext context, int index) {
                      EmployeeItemEntity item = itemsInCategory[index];
                      // Return a widget representing the item
                      return Dismissible(
                        key: Key("${item.id}"),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) {
                          bloc.add(
                              ItemDismissedEvent(context: context, item: item));
                        },
                        background: const ColoredBox(
                          color: Colors.red,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: ImageIcon(
                                AssetImage(deleteIcon),
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ),
                        child: ListTile(
                          dense: true,
                          minVerticalPadding: 0,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          title: Text(
                            item.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: textFieldColor),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                item.role.roleDisplayName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                    color: tertiaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Builder(builder: (context) {
                                var endDate = item.endDate;
                                String text = endDate != null
                                    ? "${formatDate(item.startDate)} - ${formatDate(item.endDate!)}"
                                    : "From ${formatDate(item.startDate)}";
                                return Text(
                                  text,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      color: tertiaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                );
                              })
                            ],
                          ),
                          onTap: () => bloc.add(NavigateToEditEmployeeScreen(
                              context: context, employeeItem: item)),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(
                      height: 0,
                      color: borderColor,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            constraints: const BoxConstraints(maxHeight: 76),
            color: noRecordsBackgroundColor,
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: const Text(
              "Swipe left to delete",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: tertiaryColor),
            ),
          ),
        )
      ],
    );
  }
}
