// lib/shared/widgets/shared_widgets.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';

// ─── Neon Card ───────────────────────────────────────────────────────────────
class NeonCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final bool showNeonBorder;
  final double borderRadius;
  final Color? backgroundColor;

  const NeonCard({
    super.key,
    required this.child,
    this.padding,
    this.showNeonBorder = false,
    this.borderRadius = 16,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = backgroundColor ??
        (isDark ? AppColors.darkCard : AppColors.lightCard);

    return Container(
      padding: padding ?? const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: showNeonBorder
              ? AppColors.neonGreen.withOpacity(0.45)
              : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
          width: showNeonBorder ? 1.2 : 1,
        ),
        boxShadow: showNeonBorder
            ? [BoxShadow(
                color: AppColors.neonGreen.withOpacity(0.12),
                blurRadius: 16, spreadRadius: 0)]
            : null,
      ),
      child: child,
    );
  }
}

// ─── Neon Button ─────────────────────────────────────────────────────────────
class NeonButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final double? width;
  final double height;
  final double fontSize;
  final Widget? prefix;
  final bool outlined;

  const NeonButton({
    super.key,
    required this.label,
    this.onTap,
    this.width,
    this.height = 48,
    this.fontSize = 15,
    this.prefix,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: outlined ? Colors.transparent : AppColors.neonGreen,
          borderRadius: BorderRadius.circular(50),
          border: outlined
              ? Border.all(color: AppColors.neonGreen, width: 1.5)
              : null,
          boxShadow: outlined
              ? null
              : AppTheme.neonGlowList(blur: 12, opacity: 0.35),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefix != null) ...[prefix!, const SizedBox(width: 6)],
            Text(
              label,
              style: GoogleFonts.tajawal(
                fontSize: fontSize,
                fontWeight: FontWeight.w800,
                color: outlined ? AppColors.neonGreen : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Section Title ────────────────────────────────────────────────────────────
class SectionTitle extends StatelessWidget {
  final String title;
  final bool neon;
  final Widget? trailing;

  const SectionTitle(this.title, {super.key, this.neon = false, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (trailing != null) trailing!,
        Text(
          title,
          style: GoogleFonts.tajawal(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: neon ? AppColors.neonGreen : Theme.of(context).textTheme.headlineSmall?.color,
          ),
          textDirection: TextDirection.rtl,
        ),
      ],
    );
  }
}

// ─── Neon Ring (circular progress) ───────────────────────────────────────────
class NeonRing extends StatelessWidget {
  final String label;
  final double current;
  final double total;
  final String unit;
  final double size;

  const NeonRing({
    super.key,
    required this.label,
    required this.current,
    required this.total,
    required this.unit,
    this.size = 88,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (current / total).clamp(0.0, 1.0);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background ring
              SizedBox(
                width: size,
                height: size,
                child: CircularProgressIndicator(
                  value: 1.0,
                  strokeWidth: 6,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation(
                    isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  ),
                ),
              ),
              // Neon ring
              SizedBox(
                width: size,
                height: size,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 6,
                  strokeCap: StrokeCap.round,
                  backgroundColor: Colors.transparent,
                  valueColor: const AlwaysStoppedAnimation(AppColors.neonGreen),
                ),
              ),
              // Center text
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.tajawal(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                    ),
                  ),
                  Text(
                    '${current.toInt()}/${total.toInt()}',
                    style: GoogleFonts.tajawal(
                      fontSize: 9,
                      color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          '${current.toInt()}/${total.toInt()}$unit',
          style: GoogleFonts.tajawal(
            fontSize: 11,
            color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
          ),
        ),
      ],
    );
  }
}

// ─── Sparkline ────────────────────────────────────────────────────────────────
class NeonSparkline extends StatelessWidget {
  final List<double> data;
  final double height;
  final bool showArea;

  const NeonSparkline({
    super.key,
    required this.data,
    this.height = 44,
    this.showArea = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: _SparklinePainter(data: data, showArea: showArea),
        size: Size.infinite,
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  final List<double> data;
  final bool showArea;

  _SparklinePainter({required this.data, this.showArea = true});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;
    final min = data.reduce((a, b) => a < b ? a : b);
    final max = data.reduce((a, b) => a > b ? a : b);
    final range = (max - min).abs();
    final safeRange = range == 0 ? 1.0 : range;

    List<Offset> points = [];
    for (int i = 0; i < data.length; i++) {
      final x = i / (data.length - 1) * size.width;
      final y = size.height - ((data[i] - min) / safeRange) * size.height * 0.85 - size.height * 0.07;
      points.add(Offset(x, y));
    }

    // Smooth path
    final path = Path();
    path.moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      final prev = points[i - 1];
      final curr = points[i];
      final cpX = (prev.dx + curr.dx) / 2;
      path.cubicTo(cpX, prev.dy, cpX, curr.dy, curr.dx, curr.dy);
    }

    // Glow paint
    final glowPaint = Paint()
      ..color = AppColors.neonGreen.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawPath(path, glowPaint);

    // Line paint
    final linePaint = Paint()
      ..color = AppColors.neonGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, linePaint);

    // Area fill
    if (showArea) {
      final areaPath = Path.from(path);
      areaPath.lineTo(points.last.dx, size.height);
      areaPath.lineTo(points.first.dx, size.height);
      areaPath.close();

      final gradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.neonGreen.withOpacity(0.2),
          AppColors.neonGreen.withOpacity(0.0),
        ],
      );
      final areaPaint = Paint()
        ..shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));
      canvas.drawPath(areaPath, areaPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ─── Metric Card ─────────────────────────────────────────────────────────────
class MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final String? unit;
  final Widget? chart;
  final bool showNeonBorder;
  final Color? valueColor;

  const MetricCard({
    super.key,
    required this.label,
    required this.value,
    this.unit,
    this.chart,
    this.showNeonBorder = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return NeonCard(
      showNeonBorder: showNeonBorder,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            label,
            style: GoogleFonts.tajawal(
              fontSize: 11,
              color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: GoogleFonts.tajawal(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: valueColor ?? (isDark ? AppColors.darkText : AppColors.lightText),
                  ),
                ),
                if (unit != null)
                  TextSpan(
                    text: ' $unit',
                    style: GoogleFonts.tajawal(
                      fontSize: 13,
                      color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                    ),
                  ),
              ],
            ),
          ),
          if (chart != null) ...[const SizedBox(height: 6), chart!],
        ],
      ),
    );
  }
}

// ─── Progress Bar ─────────────────────────────────────────────────────────────
class NeonProgressBar extends StatelessWidget {
  final double value;
  final double height;
  final Color? backgroundColor;

  const NeonProgressBar({
    super.key,
    required this.value,
    this.height = 6,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: LinearProgressIndicator(
        value: value.clamp(0.0, 1.0),
        minHeight: height,
        backgroundColor: backgroundColor ??
            (isDark ? AppColors.darkCard2 : AppColors.lightCard2),
        valueColor: const AlwaysStoppedAnimation(AppColors.neonGreen),
      ),
    );
  }
}

// ─── FAB (Floating Action Button) ────────────────────────────────────────────
class NeonFAB extends StatelessWidget {
  final VoidCallback onTap;
  final String? label;

  const NeonFAB({super.key, required this.onTap, this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: label != null ? 48 : 52,
        width: label != null ? double.infinity : 52,
        decoration: BoxDecoration(
          color: AppColors.neonGreen,
          borderRadius: label != null
              ? BorderRadius.circular(50)
              : BorderRadius.circular(26),
          boxShadow: AppTheme.neonGlowList(blur: 16, opacity: 0.5),
        ),
        child: label != null
            ? Center(
                child: Text(
                  label!,
                  style: GoogleFonts.tajawal(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              )
            : const Icon(Icons.add, color: Colors.black, size: 28),
      ),
    );
  }
}

// ─── Habit Row ────────────────────────────────────────────────────────────────
class HabitRow extends StatelessWidget {
  final String emoji;
  final String label;
  final bool isCompleted;
  final VoidCallback onToggle;
  final bool showBorder;

  const HabitRow({
    super.key,
    required this.emoji,
    required this.label,
    required this.isCompleted,
    required this.onToggle,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: showBorder
            ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                    width: 1,
                  ),
                ),
              )
            : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Checkbox
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: isCompleted ? AppColors.neonGreen : Colors.transparent,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: isCompleted ? AppColors.neonGreen : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                  width: 1.5,
                ),
                boxShadow: isCompleted ? AppTheme.neonGlowList(blur: 8, opacity: 0.4) : null,
              ),
              child: isCompleted
                  ? const Icon(Icons.check, size: 14, color: Colors.black)
                  : null,
            ),
            // Label
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '$emoji  $label',
                  style: GoogleFonts.tajawal(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Remove Button ────────────────────────────────────────────────────────────
class RemoveButton extends StatelessWidget {
  final VoidCallback onTap;

  const RemoveButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 22,
        height: 22,
        decoration: const BoxDecoration(
          color: AppColors.red,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.remove, color: Colors.white, size: 14),
      ),
    );
  }
}

// ─── Set Dots ─────────────────────────────────────────────────────────────────
class SetDots extends StatelessWidget {
  final int total;
  final int completed;

  const SetDots({super.key, required this.total, required this.completed});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: List.generate(total, (i) {
        final done = i < completed;
        return Container(
          margin: const EdgeInsets.only(left: 4),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: done ? AppColors.neonGreen : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: done ? AppColors.neonGreen : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            ),
            boxShadow: done ? [AppTheme.neonGlow(blur: 6, opacity: 0.5)] : null,
          ),
        );
      }),
    );
  }
}

// ─── Week Day Strip ───────────────────────────────────────────────────────────
class WeekDayStrip extends StatelessWidget {
  final int todayIndex; // 0=Mon
  final List<bool> completedDays;

  const WeekDayStrip({
    super.key,
    required this.todayIndex,
    required this.completedDays,
  });

  static const days = ['ج', 'خ', 'ر', 'ث', 'ن', 'ح', 'س'];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (i) {
        final isToday = i == todayIndex;
        final done = completedDays.length > i && completedDays[i];
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: isToday
                  ? AppColors.neonGreen
                  : done
                      ? AppColors.neonGreenDim
                      : (isDark ? AppColors.darkCard2 : AppColors.lightCard2),
              borderRadius: BorderRadius.circular(8),
              boxShadow: isToday ? AppTheme.neonGlowList(blur: 8, opacity: 0.4) : null,
            ),
            child: Column(
              children: [
                Text(
                  days[i],
                  style: GoogleFonts.tajawal(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: isToday
                        ? Colors.black
                        : done
                            ? AppColors.neonGreen
                            : (isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
                  ),
                ),
                if (done || isToday)
                  Icon(
                    Icons.check,
                    size: 9,
                    color: isToday ? Colors.black : AppColors.neonGreen,
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

// ─── Badge Widget ─────────────────────────────────────────────────────────────
class AchievementBadge extends StatelessWidget {
  final String emoji;
  final String name;
  final bool isUnlocked;

  const AchievementBadge({
    super.key,
    required this.emoji,
    required this.name,
    this.isUnlocked = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isUnlocked
                ? AppColors.neonGreenDim
                : (isDark ? AppColors.darkCard2 : AppColors.lightCard2),
            border: Border.all(
              color: isUnlocked ? AppColors.neonGreen : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
              width: 1.5,
            ),
            boxShadow: isUnlocked
                ? [BoxShadow(color: AppColors.neonGreen.withOpacity(0.2), blurRadius: 12)]
                : null,
          ),
          child: Center(
            child: isUnlocked
                ? Text(emoji, style: const TextStyle(fontSize: 22))
                : const Icon(Icons.lock, color: AppColors.darkTextMuted, size: 20),
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: 64,
          child: Text(
            name,
            style: GoogleFonts.tajawal(
              fontSize: 9,
              color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}

// ─── Bottom Sheet Wrapper ─────────────────────────────────────────────────────
class NeonBottomSheet extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const NeonBottomSheet({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightBg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: const Border(
          top: BorderSide(color: AppColors.neonGreen, width: 1),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Center(
            child: Container(
              width: 36,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Text(
            title,
            style: GoogleFonts.tajawal(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.neonGreen,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

// ─── Input Field ─────────────────────────────────────────────────────────────
class NeonInputField extends StatelessWidget {
  final String label;
  final String? value;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const NeonInputField({
    super.key,
    required this.label,
    this.value,
    this.hint,
    this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard2 : AppColors.lightCard2,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.neonGreen.withOpacity(0.35),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value ?? (controller?.text.isEmpty ?? true ? hint ?? '' : controller!.text),
            style: GoogleFonts.tajawal(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: value != null && value!.isNotEmpty
                  ? AppColors.neonGreen
                  : (isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
            ),
          ),
          Text(
            label,
            style: GoogleFonts.tajawal(
              fontSize: 12,
              color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Calorie Ring Card ────────────────────────────────────────────────────────
class CalorieRingCard extends StatelessWidget {
  final double current;
  final double total;

  const CalorieRingCard({super.key, required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progress = (current / total).clamp(0.0, 1.0);
    return NeonCard(
      showNeonBorder: true,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'السعرات',
            style: GoogleFonts.tajawal(
              fontSize: 11,
              color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
            ),
          ),
          const SizedBox(height: 6),
          Center(
            child: SizedBox(
              width: 72,
              height: 72,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: 1.0,
                    strokeWidth: 6,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation(
                      isDark ? AppColors.darkBorder : AppColors.lightBorder,
                    ),
                  ),
                  CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 6,
                    strokeCap: StrokeCap.round,
                    backgroundColor: Colors.transparent,
                    valueColor: const AlwaysStoppedAnimation(AppColors.neonGreen),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('🔥', style: TextStyle(fontSize: 14)),
                      Text(
                        '${current.toInt()}',
                        style: GoogleFonts.tajawal(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: isDark ? AppColors.darkText : AppColors.lightText,
                        ),
                      ),
                      Text(
                        'kcal',
                        style: GoogleFonts.tajawal(
                          fontSize: 8,
                          color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          Center(
            child: Text(
              '${current.toInt()} / ${total.toInt()} kcal',
              style: GoogleFonts.tajawal(
                fontSize: 10,
                color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
