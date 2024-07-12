import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_gender/auth/controllers/firebase_base_provider.dart';
import 'package:my_gender/tracker/views/period_input_form.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const DashboardScreen()));
              },
              child: const Text("Ex 1")),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MenstrualPeriodScreen()));
              },
              child: const Text("Ex 2")),
        ],
      ),
    ));
  }
}

class MenstrualPeriodScreen extends ConsumerStatefulWidget {
  const MenstrualPeriodScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MenstrualPeriodScreenState();
}

class _MenstrualPeriodScreenState extends ConsumerState<MenstrualPeriodScreen> {
  DateTime currentDate = DateTime.now();
  DateTime lastStartDate = DateTime.now()
      .subtract(const Duration(days: 18)); // Example last period start date
  int periodLength = 4;
  int cycleLength = 28;

  @override
  Widget build(BuildContext context) {
    final String userName =
        ref.read(firebaseProvider).currentUser?.displayName ?? '';
    DateTime predictedDate = lastStartDate.add(Duration(days: cycleLength));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menstrual Period Tracker'),
        centerTitle: true,
        leading: const SizedBox(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Good morning,',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(userName,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 24,
                      )),
              const SizedBox(height: 20),
              CalendarDatePicker(
                initialDate: currentDate,
                firstDate: DateTime(currentDate.year, currentDate.month - 1),
                lastDate: DateTime(currentDate.year, currentDate.month + 1),
                onDateChanged: (date) {},
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Text(
                    'Your period is likely to start on or around ${DateFormat('MMMM d').format(predictedDate)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontSize: 16,
                        )),
              ),
              const SizedBox(height: 20),
              const Text(
                'Last Menstrual Period',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(
                  Icons.calendar_today,
                ),
                title: Text(
                    'Started ${DateFormat('MMMM d').format(lastStartDate)}'),
                subtitle: Text(
                    '${DateTime.now().difference(lastStartDate).inDays} days ago'),
              ),
              ListTile(
                leading: const Icon(Icons.access_time),
                title: Text('Period Length: $periodLength days'),
                subtitle: const Text('Normal'),
              ),
              ListTile(
                leading: const Icon(Icons.repeat),
                title: Text('Cycle Length: $cycleLength days'),
                subtitle: const Text('Normal'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _logLastPeriod,
        child: const Icon(Icons.edit),
      ),
    );
  }

  void _logLastPeriod() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(currentDate.year - 1),
      lastDate: DateTime(currentDate.year + 1),
    );

    if (pickedDate != null && pickedDate != lastStartDate) {
      setState(() {
        lastStartDate = pickedDate;
      });
    }
  }
}
