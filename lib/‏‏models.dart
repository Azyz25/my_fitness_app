// lib/shared/models/models.dart

class WeightEntry {
  final DateTime date;
  final double weight;
  final double fatPercent;
  final double musclePercent;
  final double? waistCm;
  final double? chestCm;

  WeightEntry({
    required this.date,
    required this.weight,
    required this.fatPercent,
    required this.musclePercent,
    this.waistCm,
    this.chestCm,
  });
}

class MealEntry {
  final String name;
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final double grams;
  final DateTime time;

  MealEntry({
    required this.name,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.grams,
    required this.time,
  });
}

class ExerciseEntry {
  final String name;
  final String muscleGroup;
  final int sets;
  final int reps;
  final double weightKg;
  final int completedSets;
  final String emoji;

  ExerciseEntry({
    required this.name,
    required this.muscleGroup,
    required this.sets,
    required this.reps,
    required this.weightKg,
    this.completedSets = 0,
    required this.emoji,
  });
}

class HabitEntry {
  final String name;
  final String emoji;
  bool isCompleted;

  HabitEntry({
    required this.name,
    required this.emoji,
    this.isCompleted = false,
  });
}

class Achievement {
  final String name;
  final String emoji;
  final bool isUnlocked;
  final double? progress;
  final double? total;

  Achievement({
    required this.name,
    required this.emoji,
    this.isUnlocked = true,
    this.progress,
    this.total,
  });
}

// Sample data
class SampleData {
  static List<WeightEntry> weights = [
    WeightEntry(date: DateTime(2014, 10, 11), weight: 74.8, fatPercent: 16.8, musclePercent: 40.2, waistCm: 88, chestCm: 105),
    WeightEntry(date: DateTime(2014, 10, 18), weight: 74.0, fatPercent: 16.5, musclePercent: 40.5, waistCm: 87, chestCm: 104),
    WeightEntry(date: DateTime(2014, 10, 25), weight: 73.5, fatPercent: 16.2, musclePercent: 40.8, waistCm: 86, chestCm: 103),
    WeightEntry(date: DateTime(2014, 11, 1), weight: 73.1, fatPercent: 16.0, musclePercent: 41.0, waistCm: 86, chestCm: 103),
    WeightEntry(date: DateTime(2014, 11, 2), weight: 72.5, fatPercent: 15.5, musclePercent: 41.5, waistCm: 85, chestCm: 102),
    WeightEntry(date: DateTime(2014, 11, 3), weight: 72.0, fatPercent: 15.0, musclePercent: 42.0, waistCm: 85, chestCm: 102),
  ];

  static List<MealEntry> meals = [
    MealEntry(name: 'صدور دجاج', calories: 450, protein: 45, carbs: 0, fat: 8, grams: 300, time: DateTime.now().subtract(const Duration(hours: 3))),
    MealEntry(name: 'أرز أبيض', calories: 300, protein: 6, carbs: 65, fat: 1, grams: 200, time: DateTime.now().subtract(const Duration(hours: 3))),
    MealEntry(name: 'سلطة خضراء', calories: 120, protein: 4, carbs: 12, fat: 6, grams: 150, time: DateTime.now().subtract(const Duration(hours: 2))),
    MealEntry(name: 'بيض مسلوق', calories: 140, protein: 12, carbs: 1, fat: 10, grams: 100, time: DateTime.now().subtract(const Duration(hours: 1))),
  ];

  static List<ExerciseEntry> exercises = [
    ExerciseEntry(name: 'صدر (الضغط)', muscleGroup: 'صدر', sets: 3, reps: 12, weightKg: 60, completedSets: 2, emoji: '💪'),
    ExerciseEntry(name: 'الأرجل (سكوات)', muscleGroup: 'أرجل', sets: 4, reps: 10, weightKg: 90, completedSets: 1, emoji: '🦵'),
    ExerciseEntry(name: 'ظهر (سحب علوي)', muscleGroup: 'ظهر', sets: 3, reps: 10, weightKg: 70, completedSets: 0, emoji: '🏋'),
    ExerciseEntry(name: 'أكتاف (دمبلز)', muscleGroup: 'أكتاف', sets: 3, reps: 15, weightKg: 20, completedSets: 0, emoji: '💪'),
  ];

  static List<HabitEntry> habits = [
    HabitEntry(name: 'شرب 2 لتر ماء', emoji: '💧', isCompleted: false),
    HabitEntry(name: 'جولة مشي 10 دقائق', emoji: '🚶', isCompleted: true),
    HabitEntry(name: 'نوم 8 ساعات', emoji: '😴', isCompleted: false),
  ];

  static List<Achievement> achievements = [
    Achievement(name: 'سلسلة 30 يوماً', emoji: '🔥', isUnlocked: true),
    Achievement(name: 'وزن ثقيل', emoji: '🏋', isUnlocked: true),
    Achievement(name: 'أول 5 كم', emoji: '🏃', isUnlocked: true),
    Achievement(name: 'بطل القوة', emoji: '💪', isUnlocked: true),
    Achievement(name: 'وزن الكنيك', emoji: '⭐', isUnlocked: true),
    Achievement(name: 'سلسلة 30 يوماً', emoji: '🔥', isUnlocked: true),
    Achievement(name: 'أكمل 10 تمارين', emoji: '🏆', isUnlocked: false, progress: 6, total: 10),
    Achievement(name: 'ماراثون شهري', emoji: '🏅', isUnlocked: false, progress: 15, total: 42),
  ];

  static List<double> weeklyActivity = [65, 30, 90, 75, 40, 70, 55];
}
