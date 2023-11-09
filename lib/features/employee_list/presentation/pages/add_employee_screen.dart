import 'package:employee_management_app/core/constants/asset_constants.dart'
    as asset_constants;
import 'package:employee_management_app/core/core.dart';
import 'package:employee_management_app/dependencies_injection.dart';
import 'package:employee_management_app/features/employee_list/domain/entities/entities.dart';
import 'package:employee_management_app/features/employee_list/presentation/presentation.dart';
import 'package:employee_management_app/utils/utils.dart';
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
      child: LayoutBuilder(builder: (context, constraints) {
        var maxHeight = constraints.maxHeight;
        var keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        return Parent(
          avoidBottomInset: maxHeight > (keyboardHeight + 200),
          appBar: AppBar(
            title: const Text("Add Employee Details"),
            automaticallyImplyLeading: false,
          ),
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
                showCustomDateDialog(
                        context: context,
                        preSelectedDay: addEmployeeParams.startDate)
                    .then((value) {
                  if (value != null &&
                      value.dateTime != null &&
                      value.dateDialogAction == DateDialogActionEnum.save) {
                    addEmployeeParams.startDate = value.dateTime;
                    startDateController.text = formatDate(value.dateTime!);
                  }
                });
              }
              if (state is ShowEndDateDialog) {
                showCustomDateDialog(
                        context: context,
                        showNoDateButton: true,
                        preSelectedDay: addEmployeeParams.endDate)
                    .then((value) {
                  if (value != null &&
                      value.dateDialogAction == DateDialogActionEnum.save) {
                    addEmployeeParams.endDate = value.dateTime;
                    endDateController.text = value.dateTime != null
                        ? formatDate(value.dateTime!)
                        : "";
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
                  _topTextFieldSectionUI(),
                  BottomButtonSection(
                      cancelOnPressed: () => Navigator.of(context).pop(),
                      saveOnPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState?.save();
                          cubit.addEmployeeOperation(addEmployeeParams);
                        }
                      })
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _topTextFieldSectionUI() {
    return Padding(
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
            prefixIcon: const ImageIcon(
              AssetImage(asset_constants.employeeNameIcon),
              size: 18,
            ),
            validator: (val) => requiredValidator(val, "Name"),
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(
            height: 23,
          ),
          CommonTextField(
            hintText: "Select role",
            prefixIcon: const ImageIcon(
              AssetImage(asset_constants.roleIcon),
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
                    AssetImage(asset_constants.dateIcon),
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
                    child: const ImageIcon(
                        AssetImage(asset_constants.rightArrowIcon)),
                  )),
              Expanded(
                flex: 172,
                child: CommonTextField(
                  onTap: () {
                    cubit.showEndDateDialog();
                  },
                  prefixIcon: const ImageIcon(
                    AssetImage(
                      asset_constants.dateIcon,
                    ),
                    size: 20,
                  ),
                  readOnly: true,
                  hintText: "No date",
                  controller: endDateController,
                  validator: (val) {
                    if (addEmployeeParams.endDate != null &&
                        addEmployeeParams.startDate != null) {
                      var diff = compareTillDays(addEmployeeParams.endDate!,
                          addEmployeeParams.startDate!);
                      if (diff < 0) {
                        return "Invalid end date";
                      }
                    }
                    return null;
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
