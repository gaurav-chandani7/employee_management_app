import 'package:employee_management_app/core/constants/constants.dart';
import 'package:employee_management_app/features/employee_list/domain/entities/entities.dart';
import 'package:flutter/material.dart';

Future<EmployeeRole?> showSelectRoleBottomModal(BuildContext context) {
  return showModalBottomSheet<EmployeeRole?>(
      barrierColor: barrierColor,
      context: context,
      builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: EmployeeRole.values
                .map((e) => ListTile(
                      title: Text(e.roleDisplayName),
                      onTap: () {
                        Navigator.of(context).pop(e);
                      },
                    ))
                .toList(),
          ));
}
