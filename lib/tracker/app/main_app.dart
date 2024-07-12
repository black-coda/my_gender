import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

final periodTrackerProvider =
    StateNotifierProvider<PeriodTrackerNotifier, PeriodTracker>((ref) {
  return PeriodTrackerNotifier();
});

class PeriodTracker {
  DateTime? lastPeriodStart;
  int periodLength;
  int cycleLength;

  PeriodTracker({
    this.lastPeriodStart,
    this.periodLength = 7,
    this.cycleLength = 31,
  });

  List<DateTime> getFuturePeriods(int monthsAhead) {
    List<DateTime> periodDates = [];
    if (lastPeriodStart == null) return periodDates;
    DateTime nextPeriodStart = lastPeriodStart!;

    while (nextPeriodStart
        .isBefore(DateTime.now().add(Duration(days: 30 * monthsAhead)))) {
      periodDates.add(nextPeriodStart);
      nextPeriodStart = nextPeriodStart.add(Duration(days: cycleLength));
    }

    return periodDates;
  }

  List<DateTime> getPeriodDays(int monthsAhead) {
    List<DateTime> periodDays = [];
    if (lastPeriodStart == null) return periodDays;
    DateTime nextPeriodStart = lastPeriodStart!;

    while (nextPeriodStart
        .isBefore(DateTime.now().add(Duration(days: 30 * monthsAhead)))) {
      for (int i = 0; i < periodLength; i++) {
        periodDays.add(nextPeriodStart.add(Duration(days: i)));
      }
      nextPeriodStart = nextPeriodStart.add(Duration(days: cycleLength));
    }

    return periodDays;
  }
}

class PeriodTrackerNotifier extends StateNotifier<PeriodTracker> {
  PeriodTrackerNotifier() : super(PeriodTracker());

  void setLastPeriodStart(DateTime date) {
    state = PeriodTracker(
      lastPeriodStart: date,
      periodLength: state.periodLength,
      cycleLength: state.cycleLength,
    );
  }

  void setPeriodLength(int length) {
    if (length <= 10) {
      state = PeriodTracker(
        lastPeriodStart: state.lastPeriodStart,
        periodLength: length,
        cycleLength: state.cycleLength,
      );
    }
  }

  void setCycleLength(int length) {
    if (length <= 35) {
      state = PeriodTracker(
        lastPeriodStart: state.lastPeriodStart,
        periodLength: state.periodLength,
        cycleLength: length,
      );
    }
  }
}

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Period Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PeriodTrackerPage(),
    );
  }
}

class PeriodTrackerPage extends ConsumerWidget {
  const PeriodTrackerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final periodTracker = ref.watch(periodTrackerProvider);
    final periodNotifier = ref.read(periodTrackerProvider.notifier);
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Period Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('1. When did your last period start?'),
            ElevatedButton(
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  periodNotifier.setLastPeriodStart(pickedDate);
                }
              },
              child: Text(
                periodTracker.lastPeriodStart == null
                    ? 'Pick a date'
                    : formatter.format(periodTracker.lastPeriodStart!),
              ),
            ),
            const SizedBox(height: 16),
            const Text('2. How long does a period last?'),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (periodTracker.periodLength > 1) {
                      periodNotifier
                          .setPeriodLength(periodTracker.periodLength - 1);
                    }
                  },
                ),
                Text('${periodTracker.periodLength} days'),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (periodTracker.periodLength < 10) {
                      periodNotifier
                          .setPeriodLength(periodTracker.periodLength + 1);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('3. How long is your cycle?'),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (periodTracker.cycleLength > 1) {
                      periodNotifier
                          .setCycleLength(periodTracker.cycleLength - 1);
                    }
                  },
                ),
                Text('${periodTracker.cycleLength} days'),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (periodTracker.cycleLength < 35) {
                      periodNotifier
                          .setCycleLength(periodTracker.cycleLength + 1);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: periodTracker.lastPeriodStart == null
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PeriodResultPage(periodTracker: periodTracker),
                        ),
                      );
                    },
              child: const Text('Track Now'),
            ),
          ],
        ),
      ),
    );
  }
}

class PeriodResultPage extends StatelessWidget {
  final PeriodTracker periodTracker;

  const PeriodResultPage({super.key, required this.periodTracker});

  @override
  Widget build(BuildContext context) {
    // Define the colors for period and fertility days
    const Color periodColor = Colors.pinkAccent;
    const Color fertilityColor = Colors.purpleAccent;

    // Get the period and fertility days
    List<DateTime> periodDays = periodTracker.getPeriodDays(3);
    List<DateTime> fertilityDays = [];
    for (DateTime periodStart in periodTracker.getFuturePeriods(3)) {
      for (int i = 10; i <= 15; i++) {
        fertilityDays.add(periodStart.add(Duration(days: i)));
      }
    }

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
                    if (periodDays.contains(day)) {
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
                    } else if (fertilityDays.contains(day)) {
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
