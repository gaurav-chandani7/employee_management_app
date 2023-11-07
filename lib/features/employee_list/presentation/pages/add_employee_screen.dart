import 'package:employee_management_app/core/widgets/parent.dart';
import 'package:employee_management_app/dependencies_injection.dart';
import 'package:employee_management_app/features/employee_list/domain/entities/add_employee_params.dart';
import 'package:employee_management_app/features/employee_list/presentation/bloc/add_employee_page/add_employee_page_cubit.dart';
import 'package:employee_management_app/features/employee_list/presentation/pages/dialogs/bottom_role_dialog.dart';
import 'package:employee_management_app/features/employee_list/presentation/pages/dialogs/date_dialog.dart';
import 'package:employee_management_app/features/employee_list/presentation/widgets/common_text_field.dart';
import 'package:employee_management_app/utils/ext/context.dart';
import 'package:employee_management_app/utils/helper/date_formatter.dart';
import 'package:employee_management_app/utils/helper/field_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final cubit = sl<AddEmployeePageCubit>();
  final roleController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final AddEmployeeParams addEmployeeParams = AddEmployeeParams.initial();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: Parent(
        child: BlocListener<AddEmployeePageCubit, AddEmployeePageState>(
          bloc: cubit,
          listener: (context, state) {
            if (state is ShowSelectRoleDialog) {
              showSelectRoleBottomModal(context).then((value) {
                if (value != null) {
                  addEmployeeParams.role = value;
                  roleController.text = value.roleDisplayName;
                }
              });
            }
            if (state is ShowStartDateDialog) {
              showStartDateDialog(
                      context: context,
                      preSelectedDate: addEmployeeParams.startDate)
                  .then((value) {
                if (value != null) {
                  addEmployeeParams.startDate = value;
                  startDateController.text = formatDate(value);
                }
              });
            }
            if (state is AddEmployeePageSuccess) {
              //Dismiss Loader
              context.dismiss();
              //Sending true to previous page
              Navigator.of(context).pop(true);
            }
            if (state is AddEmployeePageLoading) {
              context.showLoading();
            }
          },
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      CommonTextField(
                        onSaved: (val) {
                          if (val != null) {
                            addEmployeeParams.employeeName = val;
                          }
                        },
                        hintText: "Employee name",
                        prefixIcon: const Icon(Icons.person_2_outlined),
                        validator: (val) => requiredValidator(val, "Name"),
                      ),
                      CommonTextField(
                        hintText: "Select role",
                        prefixIcon: const Icon(Icons.luggage),
                        readOnly: true,
                        controller: roleController,
                        onTap: () => cubit.showSelectRoleDialog(),
                        validator: (val) => requiredValidator(val, "Role"),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CommonTextField(
                              onTap: () => cubit.showStartDateDialog(),
                              prefixIcon: const Icon(Icons.calendar_month),
                              readOnly: true,
                              controller: startDateController,
                              validator: (val) =>
                                  requiredValidator(val, "Date"),
                            ),
                          ),
                          Expanded(
                            child: CommonTextField(
                              onTap: () {},
                              prefixIcon: const Icon(Icons.calendar_month),
                              readOnly: true,
                              controller: endDateController,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("Cancel")),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  _formKey.currentState?.save();
                                  cubit.addEmployeeOperation(
                                      context: context,
                                      addEmployeeParams: addEmployeeParams);
                                }
                              },
                              child: const Text("Save")),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
