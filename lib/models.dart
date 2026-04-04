import 'package:isar/isar.dart';

part 'models.g.dart'; 

@collection
class BodyMetrics {
  Id id = Isar.autoIncrement;
  DateTime date = DateTime.now();
  double weight = 0;
  double bmi = 0;
  double bodyFat = 0; 
  double muscleMass = 0; 
  double bodyWater = 0; 
  int visceralFat = 0; 
  double boneMass = 0; 
  double protein = 0; 
  double bmr = 0; 

  BodyMetrics(); // مشيد فارغ ضروري لـ Isar
}

@collection
class FoodTemplate {
  Id id = Isar.autoIncrement;
  String? name;
  double? cal;
  FoodTemplate({required this.name, required this.cal});
}

@collection
class DailyMealLog {
  Id id = Isar.autoIncrement;
  DateTime date = DateTime.now();
  double targetCal = 2200;

  // ✅ التعديل الجوهري هنا: نستخدم Links للربط بين الجداول
  final meals = IsarLinks<FoodTemplate>(); 
}