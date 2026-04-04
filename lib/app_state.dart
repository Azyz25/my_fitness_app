import 'package:flutter/material.dart';
import 'package:health/health.dart'; // تأكد من استيراد المكتبة
import 'models.dart';

class AppState extends ChangeNotifier {
  // التغيير هنا: استخدام الاسم الجديد للمكتبة
  Health health = Health(); 
  
  List<FoodTemplate> savedTemplates = [
    FoodTemplate(name: "بيض مسلوق", cal: 140),
    FoodTemplate(name: "صدر دجاج 200ج", cal: 330),
  ];

  void addFoodFromTemplate(FoodTemplate template) {
    // هنا تضع منطق إضافة الوجبة لسجلك اليومي
    print("تم إضافة ${template.name}");
    notifyListeners();
  }

  // دالة لطلب التصريح من Apple Health
  Future<void> setupHealth() async {
    var types = [HealthDataType.STEPS, HealthDataType.WEIGHT];
    await health.requestAuthorization(types);
  }
}