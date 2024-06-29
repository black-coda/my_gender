import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_gender/tracker/model/model_two.dart';

final periodTrackerProvider = Provider<PeriodTracker>((ref) {
  return PeriodTracker();
});

// State notifier for periods and next period prediction
class PeriodStateNotifier extends StateNotifier<List<Period>> {
  PeriodStateNotifier(this.ref) : super([]) {
    _loadPeriods();
  }

  final Ref ref;

  Future<void> _loadPeriods() async {
    final periodTracker = ref.read(periodTrackerProvider);
    final periods = await periodTracker.getPeriods();
    state = periods;
  }

  Future<DateTime?> predictNextPeriodStart() async {
    final periodTracker = ref.read(periodTrackerProvider);
    return periodTracker.predictNextPeriodStart();
  }

  Future<void> addPeriod(Period period) async {
    final periodTracker = ref.read(periodTrackerProvider);
    await periodTracker.savePeriod(period);
    _loadPeriods(); // Reload periods after adding a new one
  }
}

// Provider for the state notifier
final periodStateNotifierProvider =
    StateNotifierProvider<PeriodStateNotifier, List<Period>>((ref) {
  return PeriodStateNotifier(ref);
});


// Provider for the next period start date prediction
final nextPeriodProvider = FutureProvider<DateTime?>((ref) async {
  final periodNotifier = ref.read(periodStateNotifierProvider.notifier);
  return periodNotifier.predictNextPeriodStart();
});
