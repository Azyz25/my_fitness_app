import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart'; // سننشئه في الخطوة التالية
import 'app_theme.dart'; // سننشئه في الخطوة التالية

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // تهيئة Isar (قاعدة البيانات المحلية)
  await AppState.initializeIsar();
  // تهيئة الإشعارات المحلية
  // ... FlutterLocalNotificationsPlugin

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
      theme: appThemeDataLocked, // تطبيق الثيم الأسود الفخم المثبت
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
  int _currentTab = 0; // 0: التغذية، 1: الميزان، 2: التمارين، 3: الإنجازات

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(title: const Text("تتبع لياقتي")),
      body: [
        const NutritionDashboardPage(), // شاشة التغذية المعتمدة (التقويم، شريط السعرات الدائري، الوجبات المنسدلة)
        const BodyAnalysisPage(), // شاشة تحليل الجسم (الرسوم البيانية fl_chart، النموذج الكامل لـ Eufy C1)
        const WorkoutsSchedulePage(), // شاشة التمارين والجدولة (منطق الجدولة بالأيام)
        const AchievementsPage(), // شاشة الإنجازات والأوسمة
      ][_currentTab],
      // النافبار العصري العائم المثبت (Floating Modern Bottom Nav)
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