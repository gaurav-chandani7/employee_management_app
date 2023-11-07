import 'package:employee_management_app/core/constants/constants.dart';

String formatDate(DateTime date) {
  return "${date.day} ${monthNames[date.month-1].substring(0, 3)} ${date.year}";
}
