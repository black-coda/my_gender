import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

void main() {
  runApp(const PeriodTrackerApp());
}

class PeriodTrackerApp extends StatelessWidget {
  const PeriodTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Period Tracker',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const PeriodTrackerHomePage(),
    );
  }
}

class PeriodTrackerHomePage extends StatefulWidget {
  const PeriodTrackerHomePage({super.key});

  @override
  _PeriodTrackerHomePageState createState() => _PeriodTrackerHomePageState();
}

class _PeriodTrackerHomePageState extends State<PeriodTrackerHomePage> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _startDate;
  DateTime? _endDate;
  FlowIntensity? _flowIntensity;
  String _nextPeriodDate = '';

  Future<void> _savePeriod() async {
    if (_formKey.currentState!.validate() &&
        _startDate != null &&
        _endDate != null &&
        _flowIntensity != null) {
      _formKey.currentState!.save();
      Period newPeriod = Period(
        startDate: _startDate!,
        endDate: _endDate!,
        flowIntensity: _flowIntensity!,
      );
      PeriodTracker tracker = PeriodTracker();
      await tracker.savePeriod(newPeriod);
      DateTime nextPeriodStart = await tracker.predictNextPeriodStart();
      setState(() {
        _nextPeriodDate = DateFormat('yyyy-MM-dd').format(nextPeriodStart);
      });
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != (isStart ? _startDate : _endDate)) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Period Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Start Date'),
                      readOnly: true,
                      controller: TextEditingController(
                        text: _startDate != null
                            ? DateFormat('yyyy-MM-dd').format(_startDate!)
                            : '',
                      ),
                      onTap: () => _selectDate(context, true),
                      validator: (value) {
                        if (_startDate == null) {
                          return 'Please select a start date';
                        }
                        return null;
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context, true),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'End Date'),
                      readOnly: true,
                      controller: TextEditingController(
                        text: _endDate != null
                            ? DateFormat('yyyy-MM-dd').format(_endDate!)
                            : '',
                      ),
                      onTap: () => _selectDate(context, false),
                      validator: (value) {
                        if (_endDate == null) {
                          return 'Please select an end date';
                        }
                        return null;
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context, false),
                  ),
                ],
              ),
              DropdownButtonFormField<FlowIntensity>(
                decoration: const InputDecoration(labelText: 'Flow Intensity'),
                value: _flowIntensity,
                items: FlowIntensity.values.map((FlowIntensity intensity) {
                  return DropdownMenuItem<FlowIntensity>(
                    value: intensity,
                    child: Text(intensity.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _flowIntensity = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a flow intensity';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _savePeriod,
                child: const Text('Save Period'),
              ),
              const SizedBox(height: 20),
              Text(
                _nextPeriodDate.isEmpty
                    ? 'Your next period date will be displayed here'
                    : 'Your next period is expected to start on: $_nextPeriodDate',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Period class
class Period {
  final DateTime startDate;
  final DateTime endDate;
  final FlowIntensity flowIntensity;
  final List<String> symptoms; // Optional

  Period({
    required this.startDate,
    required this.endDate,
    required this.flowIntensity,
    this.symptoms = const [],
  });

  // Calculate duration
  int get durationInDays => endDate.difference(startDate).inDays + 1;

  // Helper methods for encoding/decoding Period objects to/from JSON
  Map<String, dynamic> toJson() => {
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'flowIntensity': flowIntensity.toString().split('.').last,
        'symptoms': symptoms,
      };

  static Period fromJson(Map<String, dynamic> json) => Period(
        startDate: DateTime.parse(json['startDate']),
        endDate: DateTime.parse(json['endDate']),
        flowIntensity: FlowIntensity.values.firstWhere(
            (e) => e.toString().split('.').last == json['flowIntensity']),
        symptoms: List<String>.from(json['symptoms']),
      );
}

// Flow intensity enum
enum FlowIntensity { light, medium, heavy }

// Shared Preferences storage (basic example)
class PeriodTracker {
  static const String _periodsKey = 'periods';

  Future<void> savePeriod(Period period) async {
    final prefs = await SharedPreferences.getInstance();
    final periods = await getPeriods(); // Load existing periods
    periods.add(period);
    final encodedPeriods = periods.map((p) => jsonEncode(p.toJson())).toList();
    await prefs.setStringList(_periodsKey, encodedPeriods);
  }

  Future<List<Period>> getPeriods() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedPeriods = prefs.getStringList(_periodsKey) ?? [];
    return encodedPeriods.map((p) => Period.fromJson(jsonDecode(p))).toList();
  }

  // Calculate average cycle length
  double getAverageCycleLength(List<Period> periods) {
    if (periods.length < 2) return 0.0; // Handle not enough data

    List<int> cycleLengths = [];
    for (int i = 1; i < periods.length; i++) {
      final diffInDays =
          periods[i].startDate.difference(periods[i - 1].startDate).inDays;
      cycleLengths.add(diffInDays);
    }
    return cycleLengths.reduce((a, b) => a + b) /
        cycleLengths.length; // Calculate average
  }

  // Predict next period start date
  Future<DateTime> predictNextPeriodStart() async {
    final periods = await getPeriods();
    if (periods.isEmpty) return DateTime.now(); // Handle no data

    final lastPeriod = periods.last;
    final averageCycleLength = getAverageCycleLength(periods);
    if (averageCycleLength == 0.0) return DateTime.now(); // Handle no data

    return lastPeriod.startDate.add(Duration(days: averageCycleLength.round()));
  }
}
