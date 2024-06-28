import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_gender/tracker/controller/period_tracker_controller.dart';
import 'package:my_gender/tracker/model/model_two.dart';
import 'package:table_calendar/table_calendar.dart';
// Import the period tracker functionality

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final periods = ref.watch(periodStateNotifierProvider);
    final nextPeriodAsyncValue = ref.watch(nextPeriodProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menstrual Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.pink,
                    shape: BoxShape.circle,
                  ),
                  markersMaxCount: 1,
                ),
              ),
              const SizedBox(height: 20),
              nextPeriodAsyncValue.when(
                data: (nextPeriodStartDate) {
                  if (nextPeriodStartDate != null) {
                    return Center(
                      child: Text(
                        'Your next period is expected to start on ${DateFormat.yMMMMd().format(nextPeriodStartDate)}.',
                        style: const TextStyle(fontSize: 18),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'Unable to predict the next period start date.',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (err, stack) => Center(
                  child: Text(
                    'Error: $err',
                    style: const TextStyle(fontSize: 18, color: Colors.red),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildCycleSummary(periods),
              const SizedBox(height: 20),
              _buildHealthInsights(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddPeriodDialog(context);
        },
        backgroundColor: Colors.pink,
        child: const Icon(Icons.edit),
      ),
    );
  }

  Widget _buildCycleSummary(List<Period> periods) {
    if (periods.isEmpty) {
      return const Text('No period data available.');
    }

    final lastPeriod = periods.last;
    final averageCycleLength = periods.length > 1
        ? periods
                .asMap()
                .entries
                .skip(1)
                .map((entry) => entry.value.startDate
                    .difference(periods[entry.key - 1].endDate)
                    .inDays)
                .reduce((a, b) => a + b) /
            (periods.length - 1)
        : 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Cycle Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
              'Average cycle length: ${averageCycleLength.toStringAsFixed(1)} days'),
          Text(
              'Last period start date: ${DateFormat.yMMMMd().format(lastPeriod.startDate)}'),
          Text('Average period duration: ${lastPeriod.durationInDays} days'),
        ],
      ),
    );
  }

  Widget _buildHealthInsights() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Health Insights',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Stay hydrated'),
          Text('Exercise regularly'),
        ],
      ),
    );
  }

  Future<void> _showAddPeriodDialog(BuildContext context) async {
    DateTime? startDate;
    DateTime? endDate;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Period'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (date != null) {
                    setState(() {
                      startDate = date;
                    });
                  }
                },
                child: Text(startDate == null
                    ? 'Select Start Date'
                    : DateFormat.yMMMMd().format(startDate!)),
              ),
              ElevatedButton(
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (date != null) {
                    setState(() {
                      endDate = date;
                    });
                  }
                },
                child: Text(endDate == null
                    ? 'Select End Date'
                    : DateFormat.yMMMMd().format(endDate!)),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (startDate != null && endDate != null) {
                  final newPeriod = Period(
                    startDate: startDate!,
                    endDate: endDate!,
                    flowIntensity: FlowIntensity.medium,
                    symptoms: [],
                  );
                  ref
                      .read(periodStateNotifierProvider.notifier)
                      .addPeriod(newPeriod);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
