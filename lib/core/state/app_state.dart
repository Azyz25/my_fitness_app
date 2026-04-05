// lib/core/state/app_state.dart
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../shared/models/models.dart';

class AppState extends ChangeNotifier {
  static Isar? _isar;
  static Isar get isar => _isar!;

  // ─── Initialize Isar ─────────────────────────────────────────────────────
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [
        BodyMetricsDBSchema,
        FoodTemplateDBSchema,
        DailyMealLogDBSchema,
        WorkoutSessionDBSchema,
        HabitDBSchema,
      ],
      directory: dir.path,
      name: 'techne_fitness',
    );
  }

  // ─── Weight / Measurements ───────────────────────────────────────────────
  List<WeightEntry> _weightEntries = List.from(SampleData.weights);
  List<WeightEntry> get weightEntries => _weightEntries;

  Future<void> loadWeightEntries() async {
    try {
      final dbEntries = await isar.bodyMetricsDBs.where().findAll();
      if (dbEntries.isNotEmpty) {
        _weightEntries = dbEntries.map(WeightEntry.fromDB).toList();
        notifyListeners();
      }
    } catch (_) {}
  }

  Future<void> addWeightEntry(WeightEntry entry) async {
    _weightEntries.add(entry);
    notifyListeners();
    try {
      await isar.writeTxn(() async {
        await isar.bodyMetricsDBs.put(entry.toDB());
      });
    } catch (_) {}
  }

  // ─── Meals ───────────────────────────────────────────────────────────────
  List<MealEntry> _meals = List.from(SampleData.meals);
  List<MealEntry> get meals => _meals;

  double get totalCalories => _meals.fold(0, (s, m) => s + m.calories);
  double get totalProtein  => _meals.fold(0, (s, m) => s + m.protein);
  double get totalCarbs    => _meals.fold(0, (s, m) => s + m.carbs);
  double get totalFat      => _meals.fold(0, (s, m) => s + m.fat);

  void addMeal(MealEntry meal) {
    _meals.add(meal);
    notifyListeners();
    try {
      isar.writeTxn(() async {
        await isar.foodTemplateDBs.put(meal.toDB());
      });
    } catch (_) {}
  }

  void removeMeal(int index) {
    _meals.removeAt(index);
    notifyListeners();
  }

  // ─── Exercises ────────────────────────────────────────────────────────────
  List<ExerciseEntry> _exercises = List.from(SampleData.exercises);
  List<ExerciseEntry> get exercises => _exercises;

  int get completedExercises => _exercises.where((e) => e.completedSets >= e.sets).length;

  void addExercise(ExerciseEntry ex) {
    _exercises.add(ex);
    notifyListeners();
  }

  void logSet(int index) {
    final ex = _exercises[index];
    if (ex.completedSets < ex.sets) {
      _exercises[index] = ExerciseEntry(
        name: ex.name,
        muscleGroup: ex.muscleGroup,
        sets: ex.sets,
        reps: ex.reps,
        weightKg: ex.weightKg,
        completedSets: ex.completedSets + 1,
        emoji: ex.emoji,
      );
      notifyListeners();
    }
  }

  // ─── Habits ───────────────────────────────────────────────────────────────
  List<HabitEntry> _habits = List.from(SampleData.habits);
  List<HabitEntry> get habits => _habits;

  void toggleHabit(int index) {
    _habits[index].isCompleted = !_habits[index].isCompleted;
    notifyListeners();
  }

  // ─── Templates (Food presets) ─────────────────────────────────────────────
  List<MealEntry> savedTemplates = [
    MealEntry(name: 'بيض مسلوق',   calories: 140, protein: 12, carbs: 1, fat: 10, grams: 100, time: DateTime.now()),
    MealEntry(name: 'صدر دجاج',    calories: 330, protein: 40, carbs: 0, fat: 8,  grams: 200, time: DateTime.now()),
    MealEntry(name: 'أرز أبيض',    calories: 180, protein: 4,  carbs: 38, fat: 0.5, grams: 100, time: DateTime.now()),
    MealEntry(name: 'سلطة خضراء',  calories: 120, protein: 4,  carbs: 12, fat: 6,  grams: 150, time: DateTime.now()),
  ];

  void addFromTemplate(MealEntry template) {
    addMeal(MealEntry(
      name: template.name,
      calories: template.calories,
      protein: template.protein,
      carbs: template.carbs,
      fat: template.fat,
      grams: template.grams,
      time: DateTime.now(),
    ));
  }
}

// ─── Theme Provider ───────────────────────────────────────────────────────────
class ThemeProvider extends ChangeNotifier {
  bool _isDark = true;
  bool get isDark => _isDark;

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
