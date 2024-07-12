import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class PeriodTracker {
  final DateTime lastPeriodStartDate;
  final int periodLength;
  final int cycleLength;

  PeriodTracker({
    required this.lastPeriodStartDate,
    required this.periodLength,
    required this.cycleLength,
  });

  List<DateTime> getPeriodDays(int numberOfCycles) {
    List<DateTime> periodDays = [];
    for (int i = 0; i < numberOfCycles; i++) {
      DateTime cycleStart =
          lastPeriodStartDate.add(Duration(days: i * cycleLength));
      for (int j = 0; j < periodLength; j++) {
        periodDays.add(cycleStart.add(Duration(days: j)));
      }
    }
    return periodDays;
  }

  List<DateTime> getFuturePeriods(int numberOfCycles) {
    List<DateTime> futurePeriods = [];
    for (int i = 0; i < numberOfCycles; i++) {
      futurePeriods
          .add(lastPeriodStartDate.add(Duration(days: i * cycleLength)));
    }
    return futurePeriods;
  }
}

class PeriodResultPage extends StatelessWidget {
  final PeriodTracker periodTracker;

  const PeriodResultPage({super.key, required this.periodTracker});

  @override
  Widget build(BuildContext context) {
    const Color periodColor = Colors.pinkAccent;
    const Color fertilityColor = Colors.purpleAccent;

    List<DateTime> periodDays = periodTracker
        .getPeriodDays(3)
        .map((date) => DateTime(date.year, date.month, date.day))
        .toList();
    List<DateTime> fertilityDays = [];
    for (DateTime periodStart in periodTracker.getFuturePeriods(3)) {
      for (int i = 10; i <= 15; i++) {
        fertilityDays.add(
            DateTime(periodStart.year, periodStart.month, periodStart.day)
                .add(Duration(days: i)));
      }
    }

    log
    ("Period Days: $periodDays");
    log
    ("Fertility Days: $fertilityDays");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Period Tracker Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Future Period and Fertility Dates:',
                style: TextStyle(fontSize: 18)),
            Expanded(
              child: TableCalendar(
                firstDay: DateTime(DateTime.now().year - 1),
                lastDay: DateTime(DateTime.now().year + 1),
                focusedDay: DateTime.now(),
                calendarFormat: CalendarFormat.month,
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    DateTime dayWithoutTime =
                        DateTime(day.year, day.month, day.day);
                    if (periodDays.contains(dayWithoutTime)) {
                      return Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: periodColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          day.day.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    } else if (fertilityDays.contains(dayWithoutTime)) {
                      return Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: fertilityColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          day.day.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }
                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final PeriodTracker periodTracker = PeriodTracker(
      lastPeriodStartDate: DateTime(2024, 7, 8),
      periodLength: 7,
      cycleLength: 31,
    );

    return MaterialApp(
      title: 'Period Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PeriodResultPage(periodTracker: periodTracker),
    );
  }
}
