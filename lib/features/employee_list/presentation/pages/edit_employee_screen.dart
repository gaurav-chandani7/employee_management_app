import 'package:employee_management_app/core/core.dart';
import 'package:employee_management_app/dependencies_injection.dart';
import 'package:employee_management_app/features/employee_list/domain/entities/entities.dart';
import 'package:employee_management_app/features/employee_list/presentation/presentation.dart';
import 'package:employee_management_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditEmployeeScreen extends StatefulWidget {
  const EditEmployeeScreen({super.key, required this.employeeItem});
  final EmployeeItemEntity employeeItem;

  @override
  State<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  late final EditEmployeeParams editEmployeeParams;
  final cubit = sl<EditEmployeePageCubit>();
  final roleController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    editEmployeeParams = EditEmployeeParams(
        id: widget.employeeItem.id,
        employeeName: widget.employeeItem.name,
        role: widget.employeeItem.role,
        startDate: widget.employeeItem.startDate,
        endDate: widget.employeeItem.endDate);
    roleController.text = editEmployeeParams.role.roleDisplayName;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: Parent(
        appBar: AppBar(
          title: const Text("Edit Employee Details"),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  cubit.showConfirmDeleteDialog();
                },
                icon: const ImageIcon(AssetImage(deleteIcon)))
          ],
        ),
        child: BlocListener<EditEmployeePageCubit, EditEmployeePageState>(
          listener: (context, state) {
            if (state is ShowRoleDialogEditPage) {
              showSelectRoleBottomModal(context).then((value) {
                if (value != null) {
                  roleController.text = value.roleDisplayName;
                  editEmployeeParams.role = value;
                }
              });
            }
            if (state is ShowStartDateDialogEditPage) {
              showStartDateDialog(
                      context: context,
                      preSelectedDate: editEmployeeParams.startDate)
                  .then((value) {
                if (value != null) {
                  editEmployeeParams.startDate = value;
                  startDateController.text = formatDate(value);
                }
              });
            }
            if (state is ShowConfirmDeleteDialogEditPage) {
              showConfirmDeleteAlertDialog(context);
            }
            if (state is EditEmployeePageLoading) {
              context.showLoading();
            }
            if (state is EditEmployeePageSuccess) {
              context.dismiss();
              Navigator.of(context).pop(true);
            }
          },
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                Column(
                  children: [
                    CommonTextField(
                      initialValue: editEmployeeParams.employeeName,
                      onSaved: (val) {
                        if (val != null) {
                          editEmployeeParams.employeeName = val;
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
                  ],
                ),
                BottomButtonSection(
                    cancelOnPressed: () => Navigator.of(context).pop(),
                    saveOnPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        cubit.editOperation(editEmployeeParams);
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
