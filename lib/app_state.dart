import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'models.dart';
import 'rules_engine.dart';
import 'package:health/health.dart';

class AppState extends ChangeNotifier {
  static late Isar isar;
  
  // الوجبات المحفوظة (Templates)
  List<FoodTemplate> savedTemplates = [];

  // تهيئة Isar عند تشغيل التطبيق
  static Future<void> initializeIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([BodyMetricsSchema, DailyMealLogSchema, FoodTemplateSchema], directory: dir.path);
  }

  // دالة لحفظ وجبة كـ محفوظة
  void saveAsTemplate(String name, double cal) async {
    final template = FoodTemplate(name: name, cal: cal);
    await isar.writeTxn(() async => isar.foodTemplates.put(template));
    savedTemplates.add(template); // تحديث القائمة
    notifyListeners();
  }

  // منطق جدولة القياس بناءً على "مدة زمنية"
  int reminderIntervalDays = 7; // التذكير كل أسبوع (مثال)
  DateTime? lastMeasurementDate; // سن سحبه من BodyMetrics

  // دالة لحساب وتطبيق الجدولة
  void updateScheduleSettings(int days) {
    reminderIntervalDays = days;
    // ... تحديث الجدولة باستخدام ScheduleEngine
    notifyListeners();
  }

  // منطق الربط مع Apple Health للايفون
  HealthFactory health = HealthFactory();
  bool isHealthConnected = false;

  Future<void> connectToHealth() async {
    final types = [HealthDataType.STEPS, HealthDataType.ACTIVE_ENERGY_BURNED];
    isHealthConnected = await health.requestAuthorization(types);
    if (isHealthConnected) {
      // سحب الخطوات والسعرات لمزامنتها معDashboard
    }
    notifyListeners();
  }
}