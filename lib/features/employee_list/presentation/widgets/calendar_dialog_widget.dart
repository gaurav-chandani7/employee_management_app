import 'package:employee_management_app/core/constants/constants.dart';
import 'package:employee_management_app/features/features.dart';
import 'package:employee_management_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarDialogWidget extends StatefulWidget {
  const CalendarDialogWidget(
      {super.key,
      this.pageAnimationDuration = const Duration(milliseconds: 300),
      this.pageAnimationCurve = Curves.easeOut,
      this.preSelectedDay,
      this.showNoDateButton = false});

  final Duration pageAnimationDuration;
  final Cubic pageAnimationCurve;
  final DateTime? preSelectedDay;
  final bool showNoDateButton;

  @override
  State<CalendarDialogWidget> createState() => _CalendarDialogWidgetState();
}

class _CalendarDialogWidgetState extends State<CalendarDialogWidget> {
  DateTime? selectedDate;
  late final PageController tableController;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.preSelectedDay;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var maxWidth = constraints.maxWidth;
      return Dialog(
        insetPadding: EdgeInsets.symmetric(
            horizontal: maxWidth < 450
                ? 16
                : maxWidth < 700
                    ? (maxWidth * 0.1)
                    : (maxWidth * 0.15)),
        child: SingleChildScrollView(
          // For Low Height devices
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 8,
                ),
                widget.showNoDateButton
                    ? _endDateActionsUI()
                    : _startDateActionsUI(),
                Container(
                  constraints: const BoxConstraints(
                    maxHeight: (45 * 6) + 20 + 16 + 70,
                  ),
                  child: TableCalendar(
                    currentDay: DateTime.now(),
                    focusedDay: selectedDate ?? DateTime.now(),
                    selectedDayPredicate: (day) => isSameDay(day, selectedDate),
                    firstDay: DateTime(2000),
                    lastDay: DateTime.now().add(const Duration(days: 365)),
                    rowHeight: 45,
                    daysOfWeekHeight: 20,
                    daysOfWeekStyle: const DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: textFieldColor),
                        weekendStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: textFieldColor)),
                    calendarBuilders: CalendarBuilders(
                      headerTitleBuilder: (context, day) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              visualDensity: VisualDensity.compact,
                              onPressed: () {
                                tableController.previousPage(
                                    duration: widget.pageAnimationDuration,
                                    curve: widget.pageAnimationCurve);
                              },
                              icon: const ImageIcon(
                                AssetImage(leftArrowCalendarIcon),
                                size: 14,
                                color: tertiaryColor,
                              )),
                          Container(
                            width: 155,
                            alignment: Alignment.center,
                            child: Text(
                              "${monthNames[day.month - 1]} ${day.year}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                          ),
                          IconButton(
                              visualDensity: VisualDensity.compact,
                              onPressed: () {
                                tableController.nextPage(
                                    duration: widget.pageAnimationDuration,
                                    curve: widget.pageAnimationCurve);
                              },
                              icon: const ImageIcon(
                                AssetImage(rightArrowCalendarIcon),
                                size: 14,
                                color: tertiaryColor,
                              )),
                        ],
                      ),
                    ),
                    headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        leftChevronVisible: false,
                        rightChevronVisible: false),
                    calendarStyle: const CalendarStyle(
                        tablePadding: EdgeInsets.symmetric(vertical: 8),
                        defaultTextStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: textFieldColor),
                        weekendTextStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: textFieldColor),
                        outsideDaysVisible: false,
                        todayTextStyle: TextStyle(color: primaryColor),
                        todayDecoration: BoxDecoration(
                            color: whiteColor,
                            shape: BoxShape.circle,
                            border: Border.fromBorderSide(
                                BorderSide(color: primaryColor))),
                        selectedTextStyle: TextStyle(color: whiteColor),
                        selectedDecoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        )),
                    onCalendarCreated: (pageController) {
                      tableController = pageController;
                    },
                    onDaySelected: (selectedD, fD) {
                      setState(() {
                        selectedDate = selectedD;
                      });
                    },
                  ),
                ),
                const Divider(
                  height: 0,
                  color: borderColor,
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const ImageIcon(AssetImage(dateIcon)),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            selectedDate != null
                                ? formatDate(selectedDate!)
                                : "No date",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: textFieldColor),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(
                                  DateDialogPopObject(
                                      dateDialogAction:
                                          DateDialogActionEnum.cancel)),
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12)),
                              child: const Text("Cancel")),
                          const SizedBox(
                            width: 16,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop(DateDialogPopObject(
                                    dateDialogAction: DateDialogActionEnum.save,
                                    dateTime: selectedDate));
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  foregroundColor: whiteColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12)),
                              child: const Text("Save"))
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Column _startDateActionsUI() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 47,
              child: _todayButton(),
            ),
            const Expanded(flex: 6, child: SizedBox()),
            Expanded(
              flex: 47,
              child: _nextMondayButton(),
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Expanded(
              flex: 47,
              child: _nextTuesdayButton(),
            ),
            const Expanded(flex: 6, child: SizedBox()),
            Expanded(
              flex: 47,
              child: _afterOneWeekButton(),
            )
          ],
        ),
      ],
    );
  }

  Column _endDateActionsUI() {
    return Column(children: [
      Row(
        children: [
          Expanded(
            flex: 47,
            child: _noDateButton(),
          ),
          const Expanded(flex: 6, child: SizedBox()),
          Expanded(
            flex: 47,
            child: _todayButton(),
          )
        ],
      ),
    ]);
  }

  ElevatedButton _afterOneWeekButton() {
    return ElevatedButton(
        onPressed: () {
          //1 week Relative to today
          setState(() {
            selectedDate = DateTime.now().add(const Duration(days: 7));
          });
        },
        child: const Text("After 1 week"));
  }

  ElevatedButton _nextTuesdayButton() {
    return ElevatedButton(
        onPressed: () {
          DateTime date = DateTime.now();
          //next tuesday Relative to today
          do {
            date = date.add(const Duration(days: 1));
          } while (date.weekday != DateTime.tuesday);
          setState(() {
            selectedDate = date;
          });
        },
        child: const Text("Next Tuesday"));
  }

  ElevatedButton _nextMondayButton() {
    return ElevatedButton(
        onPressed: () {
          DateTime date = DateTime.now();
          //next monday Relative to today
          do {
            date = date.add(const Duration(days: 1));
          } while (date.weekday != DateTime.monday);
          setState(() {
            selectedDate = date;
          });
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor, foregroundColor: whiteColor),
        child: const Text("Next Monday"));
  }

  ElevatedButton _todayButton() {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            selectedDate = DateTime.now();
          });
        },
        child: const Text("Today"));
  }

  ElevatedButton _noDateButton() {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            selectedDate = null;
          });
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor, foregroundColor: whiteColor),
        child: const Text("No Date"));
  }
}
