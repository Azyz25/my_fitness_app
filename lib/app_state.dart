import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'models.dart';

class AppState extends ChangeNotifier {
  Health health = Health(); 
  static Isar? isar;

  // الدالة التي كان يشتكي الـ Build من فقدانها
  static Future<void> initializeIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [BodyMetricsSchema, FoodTemplateSchema, DailyMealLogSchema],
      directory: dir.path,
    );
  }
  
  List<FoodTemplate> savedTemplates = [
    FoodTemplate(name: "بيض مسلوق", cal: 140),
    FoodTemplate(name: "صدر دجاج 200ج", cal: 330),
  ];

  void addFoodFromTemplate(FoodTemplate template) {
    print("تم إضافة ${template.name}");
    notifyListeners();
  }

  Future<void> setupHealth() async {
    var types = [HealthDataType.STEPS, HealthDataType.WEIGHT];
    await health.requestAuthorization(types);
  }
}