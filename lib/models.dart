// lib/shared/models/models.dart
import 'package:isar/isar.dart';

part 'models.g.dart';

// ─── Isar Collections ────────────────────────────────────────────────────────

@collection
class BodyMetricsDB {
  Id id = Isar.autoIncrement;
  DateTime date = DateTime.now();
  double weight = 0;
  double bodyFat = 0;
  double muscleMass = 0;
  double? waistCm;
  double? chestCm;
  double bmi = 0;
  double bmr = 0;
  double bodyWater = 0;
  int visceralFat = 0;
  BodyMetricsDB();
}

@collection
class FoodTemplateDB {
  Id id = Isar.autoIncrement;
  String? name;
  double? cal;
  double? protein;
  double? carbs;
  double? fat;
  double? grams;
  FoodTemplateDB({this.name, this.cal, this.protein, this.carbs, this.fat, this.grams});
}

@collection
class DailyMealLogDB {
  Id id = Isar.autoIncrement;
  DateTime date = DateTime.now();
  double targetCal = 2300;
  final meals = IsarLinks<FoodTemplateDB>();
}

@collection
class WorkoutSessionDB {
  Id id = Isar.autoIncrement;
  DateTime date = DateTime.now();
  String? exerciseName;
  String? muscleGroup;
  int sets = 0;
  int reps = 0;
  double weightKg = 0;
  int completedSets = 0;
  WorkoutSessionDB();
}

@collection
class HabitDB {
  Id id = Isar.autoIncrement;
  String? name;
  String? emoji;
  bool isCompleted = false;
  DateTime date = DateTime.now();
  HabitDB();
}

// ─── User Goals Model ─────────────────────────────────────────────────────────

class UserGoals {
  final double targetCalories;
  final double targetProtein;
  final double targetCarbs;
  final double targetFat;
  final double targetWaterGlasses;

  const UserGoals({
    this.targetCalories = 2300,
    this.targetProtein = 180,
    this.targetCarbs = 250,
    this.targetFat = 70,
    this.targetWaterGlasses = 8,
  });

  UserGoals copyWith({
    double? targetCalories,
    double? targetProtein,
    double? targetCarbs,
    double? targetFat,
    double? targetWaterGlasses,
  }) {
    return UserGoals(
      targetCalories: targetCalories ?? this.targetCalories,
      targetProtein: targetProtein ?? this.targetProtein,
      targetCarbs: targetCarbs ?? this.targetCarbs,
      targetFat: targetFat ?? this.targetFat,
      targetWaterGlasses: targetWaterGlasses ?? this.targetWaterGlasses,
    );
  }

  Map<String, dynamic> toJson() => {
    'targetCalories': targetCalories,
    'targetProtein': targetProtein,
    'targetCarbs': targetCarbs,
    'targetFat': targetFat,
    'targetWaterGlasses': targetWaterGlasses,
  };

  factory UserGoals.fromJson(Map<String, dynamic> json) => UserGoals(
    targetCalories: (json['targetCalories'] as num?)?.toDouble() ?? 2300,
    targetProtein: (json['targetProtein'] as num?)?.toDouble() ?? 180,
    targetCarbs: (json['targetCarbs'] as num?)?.toDouble() ?? 250,
    targetFat: (json['targetFat'] as num?)?.toDouble() ?? 70,
    targetWaterGlasses: (json['targetWaterGlasses'] as num?)?.toDouble() ?? 8,
  );
}

// ─── In-Memory Models (UI layer) ─────────────────────────────────────────────

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

  factory WeightEntry.fromDB(BodyMetricsDB db) => WeightEntry(
    date: db.date,
    weight: db.weight,
    fatPercent: db.bodyFat,
    musclePercent: db.muscleMass,
    waistCm: db.waistCm,
    chestCm: db.chestCm,
  );

  BodyMetricsDB toDB() {
    return BodyMetricsDB()
      ..date = date
      ..weight = weight
      ..bodyFat = fatPercent
      ..muscleMass = musclePercent
      ..waistCm = waistCm
      ..chestCm = chestCm;
  }

  Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'weight': weight,
    'fatPercent': fatPercent,
    'musclePercent': musclePercent,
    'waistCm': waistCm,
    'chestCm': chestCm,
  };

  factory WeightEntry.fromJson(Map<String, dynamic> json) => WeightEntry(
    date: DateTime.parse(json['date'] as String),
    weight: (json['weight'] as num).toDouble(),
    fatPercent: (json['fatPercent'] as num).toDouble(),
    musclePercent: (json['musclePercent'] as num).toDouble(),
    waistCm: (json['waistCm'] as num?)?.toDouble(),
    chestCm: (json['chestCm'] as num?)?.toDouble(),
  );
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

  factory MealEntry.fromDB(FoodTemplateDB db) => MealEntry(
    name: db.name ?? '',
    calories: db.cal ?? 0,
    protein: db.protein ?? 0,
    carbs: db.carbs ?? 0,
    fat: db.fat ?? 0,
    grams: db.grams ?? 100,
    time: DateTime.now(),
  );

  FoodTemplateDB toDB() => FoodTemplateDB(
    name: name,
    cal: calories,
    protein: protein,
    carbs: carbs,
    fat: fat,
    grams: grams,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'calories': calories,
    'protein': protein,
    'carbs': carbs,
    'fat': fat,
    'grams': grams,
    'time': time.toIso8601String(),
  };

  factory MealEntry.fromJson(Map<String, dynamic> json) => MealEntry(
    name: json['name'] as String,
    calories: (json['calories'] as num).toDouble(),
    protein: (json['protein'] as num).toDouble(),
    carbs: (json['carbs'] as num).toDouble(),
    fat: (json['fat'] as num).toDouble(),
    grams: (json['grams'] as num).toDouble(),
    time: DateTime.parse(json['time'] as String),
  );
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

  ExerciseEntry copyWith({int? completedSets}) => ExerciseEntry(
    name: name,
    muscleGroup: muscleGroup,
    sets: sets,
    reps: reps,
    weightKg: weightKg,
    completedSets: completedSets ?? this.completedSets,
    emoji: emoji,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'muscleGroup': muscleGroup,
    'sets': sets,
    'reps': reps,
    'weightKg': weightKg,
    'completedSets': completedSets,
    'emoji': emoji,
  };

  factory ExerciseEntry.fromJson(Map<String, dynamic> json) => ExerciseEntry(
    name: json['name'] as String,
    muscleGroup: json['muscleGroup'] as String,
    sets: json['sets'] as int,
    reps: json['reps'] as int,
    weightKg: (json['weightKg'] as num).toDouble(),
    completedSets: json['completedSets'] as int? ?? 0,
    emoji: json['emoji'] as String? ?? '💪',
  );
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

  Map<String, dynamic> toJson() => {
    'name': name,
    'emoji': emoji,
    'isCompleted': isCompleted,
  };

  factory HabitEntry.fromJson(Map<String, dynamic> json) => HabitEntry(
    name: json['name'] as String,
    emoji: json['emoji'] as String,
    isCompleted: json['isCompleted'] as bool? ?? false,
  );
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

// ─── Sample / Default Data ────────────────────────────────────────────────────

class SampleData {
  static List<WeightEntry> get defaultWeights => [
    WeightEntry(date: DateTime(2024, 10, 11), weight: 74.8, fatPercent: 16.8, musclePercent: 40.2, waistCm: 88, chestCm: 105),
    WeightEntry(date: DateTime(2024, 10, 18), weight: 74.0, fatPercent: 16.5, musclePercent: 40.5, waistCm: 87, chestCm: 104),
    WeightEntry(date: DateTime(2024, 10, 25), weight: 73.5, fatPercent: 16.2, musclePercent: 40.8, waistCm: 86, chestCm: 103),
    WeightEntry(date: DateTime(2024, 11, 1),  weight: 73.1, fatPercent: 16.0, musclePercent: 41.0, waistCm: 86, chestCm: 103),
    WeightEntry(date: DateTime(2024, 11, 2),  weight: 72.5, fatPercent: 15.5, musclePercent: 41.5, waistCm: 85, chestCm: 102),
    WeightEntry(date: DateTime(2024, 11, 3),  weight: 72.0, fatPercent: 15.0, musclePercent: 42.0, waistCm: 85, chestCm: 102),
  ];

  static List<MealEntry> get defaultMeals => [
    MealEntry(name: 'صدور دجاج',  calories: 450, protein: 45, carbs: 0,  fat: 8,  grams: 300, time: DateTime.now().subtract(const Duration(hours: 3))),
    MealEntry(name: 'أرز أبيض',   calories: 300, protein: 6,  carbs: 65, fat: 1,  grams: 200, time: DateTime.now().subtract(const Duration(hours: 3))),
    MealEntry(name: 'سلطة خضراء', calories: 120, protein: 4,  carbs: 12, fat: 6,  grams: 150, time: DateTime.now().subtract(const Duration(hours: 2))),
    MealEntry(name: 'بيض مسلوق',  calories: 140, protein: 12, carbs: 1,  fat: 10, grams: 100, time: DateTime.now().subtract(const Duration(hours: 1))),
  ];

  static List<ExerciseEntry> get defaultExercises => [
    ExerciseEntry(name: 'صدر (الضغط)',    muscleGroup: 'صدر',   sets: 3, reps: 12, weightKg: 60, completedSets: 0, emoji: '💪'),
    ExerciseEntry(name: 'الأرجل (سكوات)', muscleGroup: 'أرجل',  sets: 4, reps: 10, weightKg: 90, completedSets: 0, emoji: '🦵'),
    ExerciseEntry(name: 'ظهر (سحب علوي)', muscleGroup: 'ظهر',   sets: 3, reps: 10, weightKg: 70, completedSets: 0, emoji: '🏋'),
    ExerciseEntry(name: 'أكتاف (دمبلز)', muscleGroup: 'أكتاف', sets: 3, reps: 15, weightKg: 20, completedSets: 0, emoji: '💪'),
  ];

  static List<HabitEntry> get defaultHabits => [
    HabitEntry(name: 'شرب 2 لتر ماء',     emoji: '💧', isCompleted: false),
    HabitEntry(name: 'جولة مشي 10 دقائق', emoji: '🚶', isCompleted: false),
    HabitEntry(name: 'نوم 8 ساعات',        emoji: '😴', isCompleted: false),
  ];

  static List<Achievement> get achievements => [
    Achievement(name: 'سلسلة 30 يوماً', emoji: '🔥', isUnlocked: true),
    Achievement(name: 'وزن ثقيل',        emoji: '🏋', isUnlocked: true),
    Achievement(name: 'أول 5 كم',        emoji: '🏃', isUnlocked: true),
    Achievement(name: 'بطل القوة',       emoji: '💪', isUnlocked: true),
    Achievement(name: 'وزن الكنيك',      emoji: '⭐', isUnlocked: true),
    Achievement(name: 'سلسلة 30 يوماً', emoji: '🔥', isUnlocked: true),
    Achievement(name: 'أكمل 10 تمارين', emoji: '🏆', isUnlocked: false, progress: 6, total: 10),
    Achievement(name: 'ماراثون شهري',    emoji: '🏅', isUnlocked: false, progress: 15, total: 42),
  ];

  static List<double> get weeklyActivity => [65, 30, 90, 75, 40, 70, 55];

  // Keep backward-compat getters used in screens that still reference SampleData
  static List<WeightEntry> weights = defaultWeights;
  static List<MealEntry> meals = defaultMeals;
  static List<ExerciseEntry> exercises = defaultExercises;
  static List<HabitEntry> habits = defaultHabits;
}
