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
    startDateController.text = formatDate(editEmployeeParams.startDate);
    if (editEmployeeParams.endDate != null) {
      endDateController.text = formatDate(editEmployeeParams.endDate!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: Parent(
        avoidBottomInset: true,
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
              showCustomDateDialog(
                      context: context,
                      preSelectedDay: editEmployeeParams.startDate)
                  .then((value) {
                if (value != null &&
                    value.dateTime != null &&
                    value.dateDialogAction == DateDialogActionEnum.save) {
                  editEmployeeParams.startDate = value.dateTime!;
                  startDateController.text = formatDate(value.dateTime!);
                }
              });
            }
            if (state is ShowEndDateDialogEditPage) {
              showCustomDateDialog(
                      context: context,
                      showNoDateButton: true,
                      preSelectedDay: editEmployeeParams.endDate)
                  .then((value) {
                if (value != null &&
                    value.dateDialogAction == DateDialogActionEnum.save) {
                  editEmployeeParams.endDate = value.dateTime;
                  endDateController.text =
                      value.dateTime != null ? formatDate(value.dateTime!) : "";
                }
              });
            }
            if (state is ShowConfirmDeleteDialogEditPage) {
              showConfirmDeleteAlertDialog(context).then((value) {
                if (value == true) {
                  cubit.deleteOperation(editEmployeeParams.id);
                }
              });
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
                _topTextFieldUI(),
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

  Padding _topTextFieldUI() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CommonTextField(
            initialValue: editEmployeeParams.employeeName,
            onSaved: (val) {
              if (val != null) {
                editEmployeeParams.employeeName = val;
              }
            },
            hintText: "Employee name",
            prefixIcon: const ImageIcon(
              AssetImage(employeeNameIcon),
              size: 18,
            ),
            validator: (val) => requiredValidator(val, "Name"),
          ),
          const SizedBox(
            height: 23,
          ),
          CommonTextField(
            hintText: "Select role",
            prefixIcon: const ImageIcon(
              AssetImage(roleIcon),
              size: 20,
            ),
            suffixIcon: const Icon(Icons.arrow_drop_down),
            readOnly: true,
            controller: roleController,
            onTap: () => cubit.showSelectRoleDialog(),
            validator: (val) => requiredValidator(val, "Role"),
          ),
          const SizedBox(
            height: 23,
          ),
          Row(
            children: [
              Expanded(
                flex: 172,
                child: CommonTextField(
                  onTap: () => cubit.showStartDateDialog(),
                  prefixIcon: const ImageIcon(
                    AssetImage(dateIcon),
                    size: 20,
                  ),
                  readOnly: true,
                  hintText: "No date",
                  controller: startDateController,
                  validator: (val) => requiredValidator(val, "Date"),
                ),
              ),
              Expanded(
                  flex: 52,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const ImageIcon(AssetImage(rightArrowIcon)),
                  )),
              Expanded(
                flex: 172,
                child: CommonTextField(
                  onTap: () {
                    cubit.showEndDateDialog();
                  },
                  prefixIcon: const ImageIcon(
                    AssetImage(
                      dateIcon,
                    ),
                    size: 20,
                  ),
                  readOnly: true,
                  hintText: "No date",
                  controller: endDateController,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
