// lib/features/fitness_provider.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../shared/models/models.dart';

// ─── Keys ─────────────────────────────────────────────────────────────────────
const _kMeals      = 'fitness_meals_v1';
const _kExercises  = 'fitness_exercises_v1';
const _kWeights    = 'fitness_weights_v1';
const _kHabits     = 'fitness_habits_v1';
const _kGoals      = 'fitness_goals_v1';
const _kWater      = 'fitness_water_v1';

// ─── ThemeProvider ────────────────────────────────────────────────────────────
class ThemeProvider extends ChangeNotifier {
  bool _isDark = true;
  bool get isDark => _isDark;

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}

// ─── FitnessProvider ──────────────────────────────────────────────────────────
class FitnessProvider extends ChangeNotifier {
  SharedPreferences? _prefs;
  bool _initialized = false;
  bool get initialized => _initialized;

  // ── State ──────────────────────────────────────────────────────────────────
  List<MealEntry>     _meals     = [];
  List<ExerciseEntry> _exercises = [];
  List<WeightEntry>   _weights   = [];
  List<HabitEntry>    _habits    = [];
  UserGoals           _goals     = const UserGoals();
  int                 _waterGlasses = 0;

  // ── Public getters ─────────────────────────────────────────────────────────
  List<MealEntry>     get meals     => List.unmodifiable(_meals);
  List<ExerciseEntry> get exercises => List.unmodifiable(_exercises);
  List<WeightEntry>   get weights   => List.unmodifiable(_weights);
  List<HabitEntry>    get habits    => List.unmodifiable(_habits);
  UserGoals           get goals     => _goals;
  int                 get waterGlasses => _waterGlasses;

  // ── Computed nutrition ─────────────────────────────────────────────────────
  double get totalCalories => _meals.fold(0.0, (s, m) => s + m.calories);
  double get totalProtein  => _meals.fold(0.0, (s, m) => s + m.protein);
  double get totalCarbs    => _meals.fold(0.0, (s, m) => s + m.carbs);
  double get totalFat      => _meals.fold(0.0, (s, m) => s + m.fat);

  double get remainingCalories =>
      (_goals.targetCalories - totalCalories).clamp(0, double.infinity);

  // ── Computed workouts ──────────────────────────────────────────────────────
  int get completedExercises =>
      _exercises.where((e) => e.completedSets >= e.sets).length;

  // ── Current weight ─────────────────────────────────────────────────────────
  double get currentWeight =>
      _weights.isEmpty ? 0 : _weights.last.weight;

  double get currentFatPercent =>
      _weights.isEmpty ? 0 : _weights.last.fatPercent;

  // ── Initialization ─────────────────────────────────────────────────────────
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    _loadAll();
    _initialized = true;
    notifyListeners();
  }

  void _loadAll() {
    _meals     = _loadMeals();
    _exercises = _loadExercises();
    _weights   = _loadWeights();
    _habits    = _loadHabits();
    _goals     = _loadGoals();
    _waterGlasses = _prefs?.getInt(_kWater) ?? 0;
  }

  // ── Persist helpers ────────────────────────────────────────────────────────
  List<MealEntry> _loadMeals() {
    final raw = _prefs?.getString(_kMeals);
    if (raw == null || raw.isEmpty) return List.from(SampleData.defaultMeals);
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list.map((e) => MealEntry.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return List.from(SampleData.defaultMeals);
    }
  }

  Future<void> _saveMeals() async {
    await _prefs?.setString(_kMeals, jsonEncode(_meals.map((e) => e.toJson()).toList()));
  }

  List<ExerciseEntry> _loadExercises() {
    final raw = _prefs?.getString(_kExercises);
    if (raw == null || raw.isEmpty) return List.from(SampleData.defaultExercises);
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list.map((e) => ExerciseEntry.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return List.from(SampleData.defaultExercises);
    }
  }

  Future<void> _saveExercises() async {
    await _prefs?.setString(_kExercises, jsonEncode(_exercises.map((e) => e.toJson()).toList()));
  }

  List<WeightEntry> _loadWeights() {
    final raw = _prefs?.getString(_kWeights);
    if (raw == null || raw.isEmpty) return List.from(SampleData.defaultWeights);
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list.map((e) => WeightEntry.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return List.from(SampleData.defaultWeights);
    }
  }

  Future<void> _saveWeights() async {
    await _prefs?.setString(_kWeights, jsonEncode(_weights.map((e) => e.toJson()).toList()));
  }

  List<HabitEntry> _loadHabits() {
    final raw = _prefs?.getString(_kHabits);
    if (raw == null || raw.isEmpty) return List.from(SampleData.defaultHabits);
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list.map((e) => HabitEntry.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return List.from(SampleData.defaultHabits);
    }
  }

  Future<void> _saveHabits() async {
    await _prefs?.setString(_kHabits, jsonEncode(_habits.map((e) => e.toJson()).toList()));
  }

  UserGoals _loadGoals() {
    final raw = _prefs?.getString(_kGoals);
    if (raw == null || raw.isEmpty) return const UserGoals();
    try {
      return UserGoals.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return const UserGoals();
    }
  }

  Future<void> _saveGoals() async {
    await _prefs?.setString(_kGoals, jsonEncode(_goals.toJson()));
  }

  // ── Meals ──────────────────────────────────────────────────────────────────
  void addMeal(MealEntry meal) {
    _meals.add(meal);
    notifyListeners();
    _saveMeals();
  }

  void removeMeal(int index) {
    if (index < 0 || index >= _meals.length) return;
    _meals.removeAt(index);
    notifyListeners();
    _saveMeals();
  }

  void clearTodayMeals() {
    _meals.clear();
    notifyListeners();
    _saveMeals();
  }

  // ── Exercises ──────────────────────────────────────────────────────────────
  void addExercise(ExerciseEntry ex) {
    _exercises.add(ex);
    notifyListeners();
    _saveExercises();
  }

  void removeExercise(int index) {
    if (index < 0 || index >= _exercises.length) return;
    _exercises.removeAt(index);
    notifyListeners();
    _saveExercises();
  }

  void logSet(int index) {
    if (index < 0 || index >= _exercises.length) return;
    final ex = _exercises[index];
    if (ex.completedSets < ex.sets) {
      _exercises[index] = ex.copyWith(completedSets: ex.completedSets + 1);
      notifyListeners();
      _saveExercises();
    }
  }

  void resetExercises() {
    _exercises = _exercises.map((e) => e.copyWith(completedSets: 0)).toList();
    notifyListeners();
    _saveExercises();
  }

  // ── Weights ────────────────────────────────────────────────────────────────
  void addWeightEntry(WeightEntry entry) {
    _weights.add(entry);
    notifyListeners();
    _saveWeights();
  }

  void removeWeightEntry(int index) {
    if (index < 0 || index >= _weights.length) return;
    _weights.removeAt(index);
    notifyListeners();
    _saveWeights();
  }

  // ── Habits ─────────────────────────────────────────────────────────────────
  void toggleHabit(int index) {
    if (index < 0 || index >= _habits.length) return;
    _habits[index].isCompleted = !_habits[index].isCompleted;
    notifyListeners();
    _saveHabits();
  }

  // ── Goals ──────────────────────────────────────────────────────────────────
  void updateGoals(UserGoals goals) {
    _goals = goals;
    notifyListeners();
    _saveGoals();
  }

  // ── Water ──────────────────────────────────────────────────────────────────
  void addWaterGlass() {
    _waterGlasses++;
    notifyListeners();
    _prefs?.setInt(_kWater, _waterGlasses);
  }

  void removeWaterGlass() {
    if (_waterGlasses > 0) {
      _waterGlasses--;
      notifyListeners();
      _prefs?.setInt(_kWater, _waterGlasses);
    }
  }

  void resetWater() {
    _waterGlasses = 0;
    notifyListeners();
    _prefs?.setInt(_kWater, 0);
  }
}
