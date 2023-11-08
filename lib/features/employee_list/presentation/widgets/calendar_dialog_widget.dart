import 'package:employee_management_app/core/constants/asset_constants.dart';
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
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.showNoDateButton
                ? _endDateActionsUI()
                : _startDateActionsUI(),
            TableCalendar(
              currentDay: DateTime.now(),
              focusedDay: selectedDate ?? DateTime.now(),
              selectedDayPredicate: (day) => isSameDay(day, selectedDate),
              firstDay: DateTime(2000),
              lastDay: DateTime.now().add(const Duration(days: 365)),
              rowHeight: 45,
              calendarBuilders: CalendarBuilders(
                headerTitleBuilder: (context, day) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          tableController.previousPage(
                              duration: widget.pageAnimationDuration,
                              curve: widget.pageAnimationCurve);
                        },
                        icon: const Icon(
                          Icons.arrow_left_rounded,
                          color: tertiaryColor,
                        )),
                    Text(
                      "${monthNames[day.month - 1]} ${day.year}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    IconButton(
                        onPressed: () {
                          tableController.nextPage(
                              duration: widget.pageAnimationDuration,
                              curve: widget.pageAnimationCurve);
                        },
                        icon: const Icon(
                          Icons.arrow_right,
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
            const Divider(
              height: 2,
              color: borderColor,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const ImageIcon(AssetImage(dateIcon)),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(selectedDate != null
                        ? formatDate(selectedDate!)
                        : "No date"),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(
                                DateDialogPopObject(
                                    dateDialogAction:
                                        DateDialogActionEnum.cancel)),
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
                                foregroundColor: whiteColor),
                            child: const Text("Save"))
                      ],
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
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
