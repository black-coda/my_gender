
enum FlowIntensity { light, medium, heavy }

class Period {
  final DateTime startDate;
  final DateTime endDate;
  final FlowIntensity flowIntensity;
  final List<String> symptoms;

  Period({
    required this.startDate,
    required this.endDate,
    required this.flowIntensity,
    this.symptoms = const [],
  });

  int get duration => endDate.difference(startDate).inDays;
}


class CycleHistory {
  List<Period> periods = [];

  void addPeriod(Period period) {
    periods.add(period);
  }

  double? getAverageCycleLength() {
    if (periods.length < 2) return null;
    List<int> cycleLengths = [];
    for (int i = 0; i < periods.length - 1; i++) {
      cycleLengths.add(
          periods[i + 1].startDate.difference(periods[i].startDate).inDays);
    }
    return cycleLengths.reduce((a, b) => a + b) / cycleLengths.length;
  }
}
