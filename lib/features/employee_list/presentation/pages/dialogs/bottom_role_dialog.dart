import 'package:employee_management_app/core/constants/constants.dart';
import 'package:employee_management_app/features/employee_list/domain/entities/entities.dart';
import 'package:flutter/material.dart';

Future<EmployeeRole?> showSelectRoleBottomModal(BuildContext context) {
  return showModalBottomSheet<EmployeeRole?>(
      context: context,
      builder: (context) => Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SafeArea(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: EmployeeRole.values.length,
                itemBuilder: (context, index) {
                  var e = EmployeeRole.values[index];
                  return InkWell(
                    child: Container(
                      constraints: const BoxConstraints(maxHeight: 52),
                      alignment: Alignment.center,
                      child: Text(
                        e.roleDisplayName,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop(e);
                    },
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  height: 0,
                  color: borderColor,
                ),
              ),
            ),
          ));
}
