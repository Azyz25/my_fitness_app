// lib/main_shell.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/theme/app_theme.dart';
import 'features/home/home_screen.dart';
import 'features/nutrition/nutrition_screen.dart';
import 'features/scale/scale_screen.dart';
import 'features/workouts/workouts_screen.dart';
import 'features/achievements/achievements_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final _screens = const [
    HomeScreen(),
    WorkoutsScreen(),
    NutritionScreen(),
    ScaleScreen(),
    AchievementsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor     = isDark ? AppColors.darkBg    : AppColors.lightBg;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: bgColor,
          border: Border(top: BorderSide(color: borderColor, width: 0.5)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(icon: Icons.home_outlined,          selectedIcon: Icons.home,          label: 'الرئيسية',  index: 0, current: _currentIndex, onTap: _onTap),
                _NavItem(icon: Icons.fitness_center_outlined, selectedIcon: Icons.fitness_center, label: 'التمارين',  index: 1, current: _currentIndex, onTap: _onTap),
                _NavItem(icon: Icons.eco_outlined,            selectedIcon: Icons.eco,            label: 'التغذية',  index: 2, current: _currentIndex, onTap: _onTap),
                _NavItem(icon: Icons.monitor_weight_outlined, selectedIcon: Icons.monitor_weight, label: 'الميزان',  index: 3, current: _currentIndex, onTap: _onTap),
                _NavItem(icon: Icons.emoji_events_outlined,   selectedIcon: Icons.emoji_events,   label: 'حسابي',    index: 4, current: _currentIndex, onTap: _onTap),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTap(int index) => setState(() => _currentIndex = index);
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final int index;
  final int current;
  final Function(int) onTap;

  const _NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.index,
    required this.current,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark   = Theme.of(context).brightness == Brightness.dark;
    final isActive = index == current;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? AppColors.neonGreen.withOpacity(0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? selectedIcon : icon,
              size: 22,
              color: isActive
                  ? AppColors.neonGreen
                  : (isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: GoogleFonts.tajawal(
                fontSize: 9,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive
                    ? AppColors.neonGreen
                    : (isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
