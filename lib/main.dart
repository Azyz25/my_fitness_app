import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'app_theme.dart';
// استيراد الصفحات (تأكد من وجود هذه الملفات أو استبدلها بـ Widgets)
// import 'pages/nutrition_page.dart'; الخ..

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // الآن ستعمل لأننا أضفنا الدالة كـ static في AppState
  await AppState.initializeIsar();

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const FitnessAppLocked(),
    ),
  );
}

class FitnessAppLocked extends StatelessWidget {
  const FitnessAppLocked({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appThemeDataLocked,
      home: const MainTabScreen(),
    );
  }
}

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});
  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تتبع لياقتي")),
      // تم التعديل هنا: حذفنا const من أمام الشاشات
      body: IndexedStack(
        index: _currentTab,
        children: [
          NutritionDashboardPage(), 
          BodyAnalysisPage(),      
          WorkoutsSchedulePage(),  
          AchievementsPage(),      
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 30, right: 30, bottom: 25),
        height: 70,
        decoration: BoxDecoration(
          color: AppColorsLocked.surface,
          borderRadius: BorderRadius.circular(35),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 5))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.pie_chart_rounded, "التغذية", 0),
            _navItem(Icons.monitor_weight_rounded, "الميزان", 1),
            _navItem(Icons.fitness_center_rounded, "التمارين", 2),
            _navItem(Icons.bookmark_rounded, "الإنجازات", 3),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    bool isSel = _currentTab == index;
    return GestureDetector(
      onTap: () => setState(() => _currentTab = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSel ? AppColorsLocked.accent : AppColorsLocked.textSecondary, size: 28),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: isSel ? AppColorsLocked.accent : AppColorsLocked.textSecondary, fontSize: 10, fontWeight: isSel ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}

// تعريفات مؤقتة للشاشات لضمان عمل الكود (استبدلها بملفاتك الحقيقية)
class NutritionDashboardPage extends StatelessWidget { const NutritionDashboardPage({super.key}); @override Widget build(BuildContext context) => Container(); }
class BodyAnalysisPage extends StatelessWidget { const BodyAnalysisPage({super.key}); @override Widget build(BuildContext context) => Container(); }
class WorkoutsSchedulePage extends StatelessWidget { const WorkoutsSchedulePage({super.key}); @override Widget build(BuildContext context) => Container(); }
class AchievementsPage extends StatelessWidget { const AchievementsPage({super.key}); @override Widget build(BuildContext context) => Container(); }