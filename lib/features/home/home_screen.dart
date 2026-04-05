// lib/features/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../core/state/app_state.dart';
import '../../shared/models/models.dart';
import '../../shared/widgets/shared_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _weightData = [74.8, 74.0, 73.5, 73.1, 72.5, 72.0];

  @override
  Widget build(BuildContext context) {
    final isDark     = Theme.of(context).brightness == Brightness.dark;
    final textColor  = isDark ? AppColors.darkText    : AppColors.lightText;
    final mutedColor = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    final appState   = context.watch<AppState>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 8),

              // ─── Header ───
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Theme toggle avatar
                  GestureDetector(
                    onTap: () => context.read<ThemeProvider>().toggleTheme(),
                    child: Container(
                      width: 42, height: 42,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.neonGreen, width: 2),
                        boxShadow: AppTheme.neonGlowList(blur: 8, opacity: 0.35),
                      ),
                      child: ClipOval(
                        child: Container(
                          color: AppColors.darkCard2,
                          child: const Center(child: Text('😊', style: TextStyle(fontSize: 20))),
                        ),
                      ),
                    ),
                  ),
                  // Greeting
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('أهلاً عزيز 👋',
                          style: GoogleFonts.tajawal(
                              fontSize: 13, color: AppColors.neonGreen, fontWeight: FontWeight.w700)),
                      Text('عبد العزيز العراجه',
                          style: GoogleFonts.tajawal(
                              fontSize: 17, fontWeight: FontWeight.w900, color: textColor)),
                      Text('السبت، 4 أبريل',
                          style: GoogleFonts.tajawal(fontSize: 11, color: mutedColor)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // ─── Stats Grid ───
              Row(
                children: [
                  Expanded(child: CalorieRingCard(current: appState.totalCalories, total: 2300)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: MetricCard(
                      label: 'الوزن الحالي ↑',
                      value: '72.5',
                      unit: 'kg',
                      showNeonBorder: true,
                      chart: const NeonSparkline(data: _weightData, height: 36),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: NeonCard(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('نسبة الدهون 🏃',
                              style: GoogleFonts.tajawal(fontSize: 11, color: mutedColor)),
                          const SizedBox(height: 4),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(text: '15',
                                  style: GoogleFonts.tajawal(fontSize: 28, fontWeight: FontWeight.w900, color: textColor)),
                              TextSpan(text: '%',
                                  style: GoogleFonts.tajawal(fontSize: 16, color: mutedColor)),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: NeonCard(
                      showNeonBorder: true,
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('التمارين المنجزة 🏋',
                              style: GoogleFonts.tajawal(fontSize: 11, color: mutedColor)),
                          const SizedBox(height: 4),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: '${appState.completedExercises}',
                                  style: GoogleFonts.tajawal(
                                      fontSize: 28, fontWeight: FontWeight.w900, color: AppColors.neonGreen)),
                              TextSpan(
                                  text: '/${appState.exercises.length}',
                                  style: GoogleFonts.tajawal(fontSize: 18, color: mutedColor)),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // ─── Active Habits ───
              const SectionTitle('الويلات النشطة'),
              const SizedBox(height: 8),
              NeonCard(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                child: Column(
                  children: List.generate(appState.habits.length, (i) {
                    final habit = appState.habits[i];
                    return HabitRow(
                      emoji: habit.emoji,
                      label: habit.name,
                      isCompleted: habit.isCompleted,
                      showBorder: i < appState.habits.length - 1,
                      onToggle: () => context.read<AppState>().toggleHabit(i),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 16),

              // ─── Daily Summary ───
              const SectionTitle('ملخص اليوم'),
              const SizedBox(height: 8),
              NeonCard(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    _statRow(context, 'السعرات المستهلكة', '${appState.totalCalories.toInt()} kcal', isDark),
                    Divider(height: 16, color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
                    _statRow(context, 'البروتين', '${appState.totalProtein.toInt()} g', isDark),
                    Divider(height: 16, color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
                    _statRow(context, 'التمارين المكتملة', '${appState.completedExercises} / ${appState.exercises.length}', isDark),
                    Divider(height: 16, color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
                    _statRow(context, 'نسبة الدهون', '15%', isDark),
                  ],
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      floatingActionButton: NeonFAB(
        onTap: () => _showQuickAdd(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _statRow(BuildContext context, String label, String value, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(value,
            style: GoogleFonts.tajawal(
                fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.neonGreen)),
        Text(label,
            style: GoogleFonts.tajawal(
                fontSize: 13,
                color: isDark ? AppColors.darkText : AppColors.lightText)),
      ],
    );
  }

  void _showQuickAdd(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => NeonBottomSheet(
        title: 'إضافة سريعة',
        children: [
          _quickOption(context, '🏋', 'تمرين جديد', isDark),
          const SizedBox(height: 8),
          _quickOption(context, '🍽', 'وجبة جديدة', isDark),
          const SizedBox(height: 8),
          _quickOption(context, '⚖', 'قياس جديد', isDark),
          const SizedBox(height: 8),
          _quickOption(context, '💧', 'شرب ماء', isDark),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _quickOption(BuildContext context, String emoji, String label, bool isDark) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard2 : AppColors.lightCard2,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(label, style: GoogleFonts.tajawal(
                fontSize: 14, fontWeight: FontWeight.w700,
                color: isDark ? AppColors.darkText : AppColors.lightText)),
            const SizedBox(width: 10),
            Text(emoji, style: const TextStyle(fontSize: 22)),
          ],
        ),
      ),
    );
  }
}
