import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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
    if (periods.isEmpty) return 0.0; // Handle empty history

    List<int> cycleLengths = [];
    for (int i = 1; i < periods.length; i++) {
      final diffInDays =
          periods[i].startDate.difference(periods[i - 1].endDate).inDays;
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

    return lastPeriod.endDate.add(Duration(days: averageCycleLength.round()));
  }
}

// Example usage
void main() async {
  final periodTracker = PeriodTracker();

  // Example: Add a new period
  final period1 = Period(
    startDate: DateTime.now().subtract(const Duration(days: 28)),
    endDate: DateTime.now().subtract(const Duration(days: 24)),
    flowIntensity: FlowIntensity.medium,
    symptoms: ['Cramps'],
  );
  await periodTracker.savePeriod(period1);

  // Access data
  final periods = await periodTracker.getPeriods();
  print(periods[0].startDate); // Print start date of the first period

  // Prediction (for informational purposes only)
  final predictedNextPeriod = await periodTracker.predictNextPeriodStart();
  print('Predicted next period start: $predictedNextPeriod');

  // Remember to display a disclaimer about prediction accuracy
}
