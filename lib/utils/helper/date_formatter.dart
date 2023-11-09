import 'package:employee_management_app/core/constants/constants.dart';

String formatDate(DateTime date) {
  var now = DateTime.now();
  var today = DateTime(now.year, now.month, now.day);
  var dayOfDate = DateTime(date.year, date.month, date.day);
  var diff = dayOfDate.difference(today).inDays;
  if (diff <= 1 && diff >= -1) {
    if (diff == 1) {
      return "Tomorrow";
    } else if (diff == 0) {
      return "Today";
    } else {
      return "Yesterday";
    }
  }
  return "${date.day} ${monthNames[date.month - 1].substring(0, 3)} ${date.year}";
}
