// lib/core/utils/rules_engine.dart
import '../../shared/models/models.dart';

/// Badge engine - checks achievement conditions
class BadgeEngine {
  /// Check if user has logged consistently for 7+ days
  static bool check7DayCuttingStreak(List<WeightEntry> entries) {
    if (entries.length < 7) return false;
    final sorted = List<WeightEntry>.from(entries)
      ..sort((a, b) => a.date.compareTo(b.date));
    int streak = 1;
    for (int i = 1; i < sorted.length; i++) {
      final diff = sorted[i].date.difference(sorted[i - 1].date).inDays;
      if (diff <= 1) {
        streak++;
        if (streak >= 7) return true;
      } else {
        streak = 1;
      }
    }
    return false;
  }

  /// Check if user has lost weight over a period
  static bool checkWeightLoss(List<WeightEntry> entries, double targetLossKg) {
    if (entries.length < 2) return false;
    final sorted = List<WeightEntry>.from(entries)
      ..sort((a, b) => a.date.compareTo(b.date));
    final loss = sorted.first.weight - sorted.last.weight;
    return loss >= targetLossKg;
  }

  /// Check total workouts completed
  static bool checkTotalWorkouts(List<ExerciseEntry> exercises, int target) {
    final done = exercises.where((e) => e.completedSets >= e.sets).length;
    return done >= target;
  }
}

/// Schedule engine - calculates next measurement/workout dates
class ScheduleEngine {
  static DateTime calculateNextMeasurementDate(DateTime lastDate, int intervalDays) {
    return lastDate.add(Duration(days: intervalDays));
  }

  static bool isDueTodayOrOverdue(DateTime scheduledDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final scheduled = DateTime(scheduledDate.year, scheduledDate.month, scheduledDate.day);
    return scheduled.compareTo(today) <= 0;
  }
}
