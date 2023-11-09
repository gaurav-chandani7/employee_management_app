import 'package:employee_management_app/core/constants/constants.dart';

String formatDate(DateTime date) {
  var now = DateTime.now();
  var diff = compareTillDays(date, now);
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

int compareTillDays(DateTime date1, DateTime date2) {
  var newDate1 = DateTime(date1.year, date1.month, date1.day);
  var newDate2 = DateTime(date2.year, date2.month, date2.day);
  return newDate1.difference(newDate2).inDays;
}
