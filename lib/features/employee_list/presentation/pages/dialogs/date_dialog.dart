import 'package:flutter/material.dart';

import 'package:employee_management_app/core/constants/constants.dart';
import 'package:employee_management_app/features/employee_list/presentation/widgets/calendar_dialog_widget.dart';

Future<DateDialogPopObject?> showCustomDateDialog(
    {required BuildContext context,
    DateTime? preSelectedDay,
    bool showNoDateButton = false}) {
  return showDialog<DateDialogPopObject>(
      context: context,
      barrierColor: barrierColor,
      builder: (context) => CalendarDialogWidget(
            preSelectedDay: preSelectedDay,
            showNoDateButton: showNoDateButton,
          ));
}

enum DateDialogActionEnum { cancel, save }

class DateDialogPopObject {
  DateDialogActionEnum dateDialogAction;
  DateTime? dateTime;
  DateDialogPopObject({
    required this.dateDialogAction,
    this.dateTime,
  });
}
