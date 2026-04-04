import 'package:intl/intl.dart';
import 'models.dart';

// محرك الأوسمة
class BadgeEngine {
  // دالة للتحقق من فتح وسام "7 أيام تنشيف"
  static bool check7DayCuttingStreak(List<DailyMealLog> logs) {
    if (logs.length < 7) return false;
    // منطق التحقق: هل التزم بالسعرات 7 أيام متتالية؟
    // ...
    return true; // مثال
  }
}

// محرك الجدولة للقياسات والتمارين
class ScheduleEngine {
  // حساب موعد القياس القادم بناءً على "فترة زمنية" (Interval)
  static DateTime calculateNextMeasurementDate(DateTime lastDate, int intervalDays) {
    return lastDate.add(Duration(days: intervalDays));
  }
  
  // دالة لجدولة تذكير يومي للتمارين
  // ... تستخدم flutter_local_notifications
}