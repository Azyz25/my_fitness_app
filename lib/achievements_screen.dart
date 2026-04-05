// lib/features/achievements/achievements_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../app_theme.dart';
import '../models.dart';
import '../shared_widgets.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final mutedColor = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

    final locked = SampleData.achievements.where((a) => !a.isUnlocked).toList();
    final unlocked = SampleData.achievements.where((a) => a.isUnlocked).toList();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 12),
              // ─── Profile Header ───
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.neonGreen, width: 2.5),
                      boxShadow: AppTheme.neonGlowList(blur: 10, opacity: 0.35),
                    ),
                    child: ClipOval(
                      child: Container(
                        color: AppColors.darkCard2,
                        child: const Center(child: Text('😊', style: TextStyle(fontSize: 28))),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'عبد العزيز أحمد العراجه',
                        style: GoogleFonts.tajawal(
                            fontSize: 16, fontWeight: FontWeight.w900, color: textColor),
                      ),
                      Text('عضو منذ 2023',
                          style: GoogleFonts.tajawal(fontSize: 11, color: mutedColor)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Divider(color: AppColors.neonGreen.withOpacity(0.3)),
              const SizedBox(height: 8),

              // ─── Techne Points ───
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : AppColors.lightCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.neonGreen.withOpacity(0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.neonGreen.withOpacity(0.08),
                      blurRadius: 16,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Text('نقاط تكنيك',
                        style: GoogleFonts.tajawal(fontSize: 12, color: mutedColor)),
                    const SizedBox(height: 4),
                    Text(
                      '4,250',
                      style: GoogleFonts.tajawal(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: AppColors.neonGreen,
                        shadows: [
                          Shadow(
                            color: AppColors.neonGreen.withOpacity(0.5),
                            blurRadius: 20,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('1,750 / 2,500',
                            style: GoogleFonts.tajawal(fontSize: 10, color: mutedColor)),
                        Text('المستوى 25',
                            style: GoogleFonts.tajawal(
                                fontSize: 10, color: AppColors.neonGreen, fontWeight: FontWeight.w700)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const NeonProgressBar(value: 0.7),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // ─── Performance Stats ───
              const SectionTitle('إحصائيات الأداء'),
              const SizedBox(height: 8),
              Row(
                children: [
                  _statBox('124', 'إجمالي التمارين', '🏋', isDark),
                  const SizedBox(width: 8),
                  _statBox('38,500', 'السعرات المحروقة', '🔥', isDark),
                  const SizedBox(width: 8),
                  _statBox('186', 'أيام النشاط', '📅', isDark),
                ],
              ),
              const SizedBox(height: 16),

              // ─── Weekly Activity ───
              const SectionTitle('النشاط الأسبوعي'),
              const SizedBox(height: 8),
              NeonCard(
                padding: const EdgeInsets.fromLTRB(12, 14, 14, 8),
                child: SizedBox(
                  height: 120,
                  child: BarChart(
                    BarChartData(
                      barTouchData: BarTouchData(enabled: false),
                      titlesData: FlTitlesData(
                        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (v, _) {
                              const days = ['ج', 'خ', 'ر', 'ث', 'ن', 'ح', 'س'];
                              final i = v.toInt();
                              if (i < 0 || i >= days.length) return const SizedBox();
                              return Text(days[i],
                                  style: GoogleFonts.tajawal(
                                      fontSize: 10, color: mutedColor));
                            },
                          ),
                        ),
                      ),
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      barGroups: SampleData.weeklyActivity.asMap().entries.map((e) {
                        return BarChartGroupData(
                          x: e.key,
                          barRods: [
                            BarChartRodData(
                              toY: e.value,
                              color: AppColors.neonGreen,
                              width: 14,
                              borderRadius: BorderRadius.circular(4),
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                toY: 100,
                                color: isDark ? AppColors.darkCard2 : AppColors.lightCard2,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // ─── Unlocked Badges ───
              const SectionTitle('الأوسمة المكتسبة'),
              const SizedBox(height: 8),
              NeonCard(
                padding: const EdgeInsets.all(14),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 14,
                  alignment: WrapAlignment.end,
                  children: unlocked.map((a) => AchievementBadge(
                    emoji: a.emoji,
                    name: a.name,
                    isUnlocked: true,
                  )).toList(),
                ),
              ),
              const SizedBox(height: 16),

              // ─── Upcoming ───
              const SectionTitle('إنجازات قادمة'),
              const SizedBox(height: 8),
              ...locked.map((a) => _UpcomingAchievement(achievement: a)),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statBox(String value, String label, String emoji, bool isDark) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 6),
            Text(value,
                style: GoogleFonts.tajawal(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: isDark ? AppColors.darkText : AppColors.lightText)),
            Text(label,
                style: GoogleFonts.tajawal(
                    fontSize: 8,
                    color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

// ─── Upcoming Achievement ─────────────────────────────────────────────────────
class _UpcomingAchievement extends StatelessWidget {
  final Achievement achievement;

  const _UpcomingAchievement({required this.achievement});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progress = achievement.progress != null && achievement.total != null
        ? (achievement.progress! / achievement.total!).clamp(0.0, 1.0)
        : 0.0;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
      ),
      child: Row(
        children: [
          // Remaining label
          if (achievement.progress != null)
            Text(
              'متبقي ${(achievement.total! - achievement.progress!).toStringAsFixed(
                achievement.total! > 20 ? 0 : 1,
              )}${achievement.total! > 20 ? 'km' : ''}',
              style: GoogleFonts.tajawal(
                  fontSize: 10, color: AppColors.neonGreen, fontWeight: FontWeight.w700),
            ),
          const SizedBox(width: 8),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(achievement.name,
                    style: GoogleFonts.tajawal(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: isDark ? AppColors.darkText : AppColors.lightText)),
                const SizedBox(height: 5),
                NeonProgressBar(value: progress),
                const SizedBox(height: 3),
                Text(
                  '${achievement.progress?.toStringAsFixed(0)}/${achievement.total?.toStringAsFixed(0)}',
                  style: GoogleFonts.tajawal(
                      fontSize: 9,
                      color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // Lock icon
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard2 : AppColors.lightCard2,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(child: Icon(Icons.lock, size: 18, color: AppColors.darkTextMuted)),
          ),
        ],
      ),
    );
  }
}
