import 'package:flutter/material.dart';

Future<DateTime?> showStartDateDialog(
    {required BuildContext context, DateTime? preSelectedDate}) {
  return showDatePicker(
      context: context,
      initialDate: preSelectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(DateTime.now().year + 1));
}
