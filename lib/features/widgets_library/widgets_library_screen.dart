// lib/features/widgets_library/widgets_library_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../core/state/app_state.dart';
import '../../shared/models/models.dart';
import '../../shared/widgets/shared_widgets.dart';

class WidgetsLibraryScreen extends StatelessWidget {
  const WidgetsLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mutedColor = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

    return Scaffold(
      appBar: AppBar(title: const Text('مكتبة الويلات')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'ويلات الشاشة الرئيسية',
              style: GoogleFonts.tajawal(fontSize: 13, color: mutedColor),
            ),
            const SizedBox(height: 12),

            // ─── Row 1: Small widgets ───
            Row(
              children: [
                Expanded(child: _QuickAddWidget(isDark: isDark)),
                const SizedBox(width: 10),
                Expanded(child: _HeartRateWidget(isDark: isDark)),
              ],
            ),
            const SizedBox(height: 10),

            // ─── Weight Curve Widget ───
            _WeightCurveWidget(isDark: isDark),
            const SizedBox(height: 10),

            // ─── Row 2: Rings + Water ───
            Row(
              children: [
                Expanded(child: _MacrosWidget(isDark: isDark)),
                const SizedBox(width: 10),
                Expanded(child: _WaterTrackerWidget(isDark: isDark)),
              ],
            ),
            const SizedBox(height: 10),

            // ─── Activity Rings ───
            _ActivityRingsWidget(isDark: isDark),
            const SizedBox(height: 10),

            // ─── Next Workout ───
            _NextWorkoutWidget(isDark: isDark),
            const SizedBox(height: 10),

            // ─── Calories Widget ───
            _CaloriesWidget(isDark: isDark),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

// ─── Quick Add Widget ─────────────────────────────────────────────────────────
class _QuickAddWidget extends StatelessWidget {
  final bool isDark;
  const _QuickAddWidget({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.neonGreen,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppTheme.neonGlowList(blur: 16, opacity: 0.45),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.add_circle_outline, color: Colors.black, size: 32),
          const SizedBox(height: 6),
          Text(
            'إضافة سريعة',
            style: GoogleFonts.tajawal(
                fontSize: 13, fontWeight: FontWeight.w800, color: Colors.black),
          ),
          const SizedBox(height: 4),
          Text(
            'تمرين / وجبة / قياس',
            style: GoogleFonts.tajawal(fontSize: 9, color: Colors.black.withOpacity(0.6)),
          ),
        ],
      ),
    );
  }
}

// ─── Heart Rate Widget ────────────────────────────────────────────────────────
class _HeartRateWidget extends StatelessWidget {
  final bool isDark;
  const _HeartRateWidget({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.favorite, color: AppColors.red, size: 18),
              Text(
                'معدل القلب',
                style: GoogleFonts.tajawal(
                    fontSize: 11,
                    color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'BPM',
                style: GoogleFonts.tajawal(
                    fontSize: 11,
                    color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
              ),
              const SizedBox(width: 4),
              Text(
                '72',
                style: GoogleFonts.tajawal(
                    fontSize: 32, fontWeight: FontWeight.w900,
                    color: isDark ? AppColors.darkText : AppColors.lightText),
              ),
            ],
          ),
          // Mini heart beat line
          SizedBox(
            height: 22,
            child: NeonSparkline(
              data: const [60, 62, 58, 70, 75, 72, 68, 72],
              height: 22,
              showArea: false,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Weight Curve Widget ──────────────────────────────────────────────────────
class _WeightCurveWidget extends StatelessWidget {
  final bool isDark;
  const _WeightCurveWidget({required this.isDark});

  static const _wData = [74.8, 74.0, 73.5, 73.1, 72.5, 72.0];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.08),
            blurRadius: 16,
          )
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.neonGreen.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'منحنى الوزن',
                  style: GoogleFonts.tajawal(
                      fontSize: 10, color: AppColors.neonGreen, fontWeight: FontWeight.w700),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    ' kg',
                    style: GoogleFonts.tajawal(
                        fontSize: 14,
                        color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
                  ),
                  Text(
                    '72.5',
                    style: GoogleFonts.tajawal(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: isDark ? AppColors.darkText : AppColors.lightText),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          NeonSparkline(data: _wData, height: 56),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '↓ 2.8 kg هذا الشهر',
                style: GoogleFonts.tajawal(
                    fontSize: 10, color: AppColors.neonGreen, fontWeight: FontWeight.w700),
              ),
              Text(
                'الوزن الحالي',
                style: GoogleFonts.tajawal(
                    fontSize: 10,
                    color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Macros Widget ────────────────────────────────────────────────────────────
class _MacrosWidget extends StatelessWidget {
  final bool isDark;
  const _MacrosWidget({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.neonGreen.withOpacity(0.3)),
        boxShadow: [BoxShadow(
            color: AppColors.neonGreen.withOpacity(0.08), blurRadius: 16)],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'الماكرو اليومي',
            style: GoogleFonts.tajawal(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _miniRing('بروتين', 140, 180, context),
                _miniRing('كارب', 200, 250, context),
                _miniRing('دهون', 55, 70, context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniRing(String label, double curr, double total, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pct = curr / total;
    return SizedBox(
      width: 54,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: 1.0,
                  strokeWidth: 4,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation(
                      isDark ? AppColors.darkBorder : AppColors.lightBorder),
                ),
                CircularProgressIndicator(
                  value: pct.clamp(0.0, 1.0),
                  strokeWidth: 4,
                  strokeCap: StrokeCap.round,
                  backgroundColor: Colors.transparent,
                  valueColor: const AlwaysStoppedAnimation(AppColors.neonGreen),
                ),
                Text(
                  '${curr.toInt()}',
                  style: GoogleFonts.tajawal(
                      fontSize: 10, fontWeight: FontWeight.w800,
                      color: isDark ? AppColors.darkText : AppColors.lightText),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(label,
              style: GoogleFonts.tajawal(
                  fontSize: 9,
                  color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted)),
        ],
      ),
    );
  }
}

// ─── Water Tracker Widget ─────────────────────────────────────────────────────
class _WaterTrackerWidget extends StatefulWidget {
  final bool isDark;
  const _WaterTrackerWidget({required this.isDark});

  @override
  State<_WaterTrackerWidget> createState() => _WaterTrackerWidgetState();
}

class _WaterTrackerWidgetState extends State<_WaterTrackerWidget> {
  int _glasses = 5;
  final int _target = 8;

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    return GestureDetector(
      onTap: () => setState(() => _glasses = (_glasses + 1) % (_target + 1)),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.water_drop, color: Color(0xFF00BFFF), size: 18),
                Text('الماء اليومي',
                    style: GoogleFonts.tajawal(
                        fontSize: 11,
                        color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted)),
              ],
            ),
            // Water level visualizer
            Column(
              children: [
                Text(
                  '$_glasses/$_target',
                  style: GoogleFonts.tajawal(
                      fontSize: 22, fontWeight: FontWeight.w900,
                      color: isDark ? AppColors.darkText : AppColors.lightText),
                ),
                Text(
                  'كأس',
                  style: GoogleFonts.tajawal(
                      fontSize: 10,
                      color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
                ),
              ],
            ),
            // Glasses row
            Wrap(
              spacing: 3,
              children: List.generate(_target, (i) {
                return Icon(
                  i < _glasses ? Icons.water_drop : Icons.water_drop_outlined,
                  size: 14,
                  color: i < _glasses
                      ? const Color(0xFF00BFFF)
                      : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                );
              }),
            ),
            NeonProgressBar(
              value: _glasses / _target,
              backgroundColor: isDark ? AppColors.darkCard2 : AppColors.lightCard2,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Activity Rings ───────────────────────────────────────────────────────────
class _ActivityRingsWidget extends StatelessWidget {
  final bool isDark;
  const _ActivityRingsWidget({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SectionTitle('حلقات النشاط اليومي'),
          const SizedBox(height: 12),
          Row(
            children: [
              // Rings SVG-style
              SizedBox(
                width: 90,
                height: 90,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer: Move
                    _ring(90, 5, AppColors.neonGreen, 0.82),
                    // Middle: Exercise
                    _ring(70, 5, const Color(0xFF00D4FF), 0.65),
                    // Inner: Stand
                    _ring(50, 5, const Color(0xFFFF6EC7), 0.9),
                    const Text('🏃', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _ringLegend('الحركة', '820 / 1,000 سعرة', AppColors.neonGreen, isDark),
                    const SizedBox(height: 8),
                    _ringLegend('التمرين', '32 / 45 دقيقة', const Color(0xFF00D4FF), isDark),
                    const SizedBox(height: 8),
                    _ringLegend('الوقوف', '10 / 12 ساعة', const Color(0xFFFF6EC7), isDark),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _ring(double size, double stroke, Color color, double progress) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        value: progress,
        strokeWidth: stroke,
        strokeCap: StrokeCap.round,
        backgroundColor: color.withOpacity(0.15),
        valueColor: AlwaysStoppedAnimation(color),
      ),
    );
  }

  Widget _ringLegend(String label, String value, Color color, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(label,
                  style: GoogleFonts.tajawal(
                      fontSize: 12, fontWeight: FontWeight.w700,
                      color: isDark ? AppColors.darkText : AppColors.lightText)),
              Text(value,
                  style: GoogleFonts.tajawal(
                      fontSize: 10, color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted)),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      ],
    );
  }
}

// ─── Next Workout Widget ──────────────────────────────────────────────────────
class _NextWorkoutWidget extends StatelessWidget {
  final bool isDark;
  const _NextWorkoutWidget({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: isDark
              ? [AppColors.darkCard, const Color(0xFF0D1A0D)]
              : [AppColors.lightCard, const Color(0xFFF0FFF0)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.neonGreen.withOpacity(0.35)),
        boxShadow: [
          BoxShadow(color: AppColors.neonGreen.withOpacity(0.08), blurRadius: 16)
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.neonGreen,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: AppTheme.neonGlowList(blur: 8, opacity: 0.3),
                ),
                child: Text(
                  'ابدأ الآن',
                  style: GoogleFonts.tajawal(
                      fontSize: 11, fontWeight: FontWeight.w700, color: Colors.black),
                ),
              ),
              Text(
                'التمرين القادم',
                style: GoogleFonts.tajawal(
                    fontSize: 13, fontWeight: FontWeight.w800,
                    color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'صدر (الضغط)',
            style: GoogleFonts.tajawal(
                fontSize: 20, fontWeight: FontWeight.w900,
                color: isDark ? AppColors.darkText : AppColors.lightText),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _chip('60 kg', isDark),
              const SizedBox(width: 6),
              _chip('12 تكرار', isDark),
              const SizedBox(width: 6),
              _chip('3 مجموعات', isDark),
            ],
          ),
          const SizedBox(height: 10),
          NeonProgressBar(value: 0.4, height: 5),
          const SizedBox(height: 4),
          Text(
            '2/5 تمارين مكتملة',
            style: GoogleFonts.tajawal(
                fontSize: 10,
                color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
          ),
        ],
      ),
    );
  }

  Widget _chip(String label, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard2 : AppColors.lightCard2,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.neonGreen.withOpacity(0.3)),
      ),
      child: Text(label,
          style: GoogleFonts.tajawal(
              fontSize: 10, color: AppColors.neonGreen, fontWeight: FontWeight.w700)),
    );
  }
}

// ─── Calories Widget ──────────────────────────────────────────────────────────
class _CaloriesWidget extends StatelessWidget {
  final bool isDark;
  const _CaloriesWidget({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Ring
          SizedBox(
            width: 80,
            height: 80,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: 1.0,
                  strokeWidth: 7,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation(
                      isDark ? AppColors.darkCard2 : AppColors.lightCard2),
                ),
                CircularProgressIndicator(
                  value: 1200 / 2300,
                  strokeWidth: 7,
                  strokeCap: StrokeCap.round,
                  backgroundColor: Colors.transparent,
                  valueColor: const AlwaysStoppedAnimation(AppColors.neonGreen),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('🔥', style: TextStyle(fontSize: 16)),
                    Text('1,200',
                        style: GoogleFonts.tajawal(
                            fontSize: 11, fontWeight: FontWeight.w900,
                            color: isDark ? AppColors.darkText : AppColors.lightText)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Text info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('السعرات اليومية',
                    style: GoogleFonts.tajawal(
                        fontSize: 13, fontWeight: FontWeight.w800,
                        color: isDark ? AppColors.darkText : AppColors.lightText)),
                const SizedBox(height: 6),
                Text('1,200 / 2,300 kcal',
                    style: GoogleFonts.tajawal(
                        fontSize: 11, color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted)),
                const SizedBox(height: 8),
                NeonProgressBar(value: 1200 / 2300),
                const SizedBox(height: 4),
                Text(
                  'متبقي 1,100 kcal',
                  style: GoogleFonts.tajawal(
                      fontSize: 10, color: AppColors.neonGreen, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
