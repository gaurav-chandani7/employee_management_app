String formatDate(DateTime date) {
  return "${date.day} ${monthNames[date.month-1].substring(0, 3)} ${date.year}";
}

const List<String> monthNames = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
];
