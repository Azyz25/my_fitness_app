// lib/features/scale/scale_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/models/models.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../fitness_provider.dart';

class ScaleScreen extends StatelessWidget {
  const ScaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FitnessProvider>(
      builder: (context, provider, _) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final mutedColor =
            isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
        final textColor = isDark ? AppColors.darkText : AppColors.lightText;
        final entries = provider.weights;

        return Scaffold(
          appBar: AppBar(
            title: const Text('الميزان'),
            leading: const BackButton(),
            actions: [
              if (entries.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.delete_sweep_outlined, size: 20),
                  tooltip: 'حذف آخر قياس',
                  onPressed: () => _confirmDeleteLast(context, provider),
                ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // ─── Summary Cards ───
                if (entries.isNotEmpty) ...[
                  Row(
                    children: [
                      Expanded(
                        child: _SummaryCard(
                          label: 'الوزن الحالي',
                          value: '${entries.last.weight}',
                          unit: 'kg',
                          emoji: '⚖️',
                          isDark: isDark,
                          neon: true,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _SummaryCard(
                          label: 'نسبة الدهون',
                          value: '${entries.last.fatPercent}',
                          unit: '%',
                          emoji: '📊',
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _SummaryCard(
                          label: 'نسبة العضل',
                          value: '${entries.last.musclePercent}',
                          unit: '%',
                          emoji: '💪',
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Weight change indicator
                  if (entries.length >= 2)
                    _WeightChangeCard(
                      entries: entries,
                      isDark: isDark,
                      mutedColor: mutedColor,
                    ),
                  const SizedBox(height: 12),
                ],

                // ─── Chart ───
                NeonCard(
                  padding: const EdgeInsets.fromLTRB(12, 14, 14, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('منحنى الوزن',
                          style: GoogleFonts.tajawal(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: textColor)),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 140,
                        child: entries.length < 2
                            ? Center(
                                child: Text(
                                  'أضف قياسَين على الأقل لعرض المنحنى',
                                  style: GoogleFonts.tajawal(
                                      fontSize: 12, color: mutedColor),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : LineChart(_buildChart(entries, isDark)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // ─── Add Button ───
                NeonButton(
                  label: 'إضافة قياس جديد',
                  onTap: () => _showAddSheet(context, provider),
                  prefix:
                      const Icon(Icons.add, color: Colors.black, size: 18),
                ),
                const SizedBox(height: 16),

                // ─── Measurements Table ───
                const SectionTitle('سجل القياسات الحيوية'),
                const SizedBox(height: 8),

                if (entries.isEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Column(
                      children: [
                        const Text('⚖️',
                            style: TextStyle(fontSize: 40)),
                        const SizedBox(height: 12),
                        Text(
                          'لم تُسجَّل قياسات بعد.\nاضغط "إضافة قياس" للبدء.',
                          style: GoogleFonts.tajawal(
                              fontSize: 13, color: mutedColor),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                else
                  NeonCard(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        _tableHeader(mutedColor),
                        const Divider(height: 12),
                        ...entries.reversed
                            .map((e) => _tableRow(e, textColor, mutedColor)),
                      ],
                    ),
                  ),
                const SizedBox(height: 80),
              ],
            ),
          ),
          // FAB on the LEFT side
          floatingActionButtonLocation:
              FloatingActionButtonLocation.startFloat,
          floatingActionButton: NeonFAB(
            onTap: () => _showAddSheet(context, provider),
          ),
        );
      },
    );
  }

  // ── Chart ──────────────────────────────────────────────────────────────────

  LineChartData _buildChart(List<WeightEntry> entries, bool isDark) {
    final spots = entries.asMap().entries
        .map((e) => FlSpot(e.key.toDouble(), e.value.weight))
        .toList();

    final minY =
        entries.map((e) => e.weight).reduce((a, b) => a < b ? a : b) - 1;
    final maxY =
        entries.map((e) => e.weight).reduce((a, b) => a > b ? a : b) + 1;

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 1,
        getDrawingHorizontalLine: (_) => FlLine(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          strokeWidth: 0.5,
          dashArray: [4, 4],
        ),
      ),
      titlesData: FlTitlesData(
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 36,
            getTitlesWidget: (v, meta) => Text(
              v.toStringAsFixed(0),
              style: GoogleFonts.tajawal(
                fontSize: 9,
                color: isDark
                    ? AppColors.darkTextMuted
                    : AppColors.lightTextMuted,
              ),
            ),
          ),
        ),
        leftTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 20,
            getTitlesWidget: (v, meta) {
              final idx = v.toInt();
              if (idx < 0 || idx >= entries.length) return const SizedBox();
              final date = entries[idx].date;
              return Text(
                '${date.day}/${date.month}',
                style: GoogleFonts.tajawal(
                  fontSize: 8,
                  color: isDark
                      ? AppColors.darkTextMuted
                      : AppColors.lightTextMuted,
                ),
              );
            },
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      minY: minY,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          curveSmoothness: 0.35,
          color: AppColors.neonGreen,
          barWidth: 2,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, _, __, ___) => FlDotCirclePainter(
              radius: 3,
              color: AppColors.neonGreen,
              strokeWidth: 0,
            ),
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.neonGreen.withOpacity(0.2),
                AppColors.neonGreen.withOpacity(0.0),
              ],
            ),
          ),
          shadow: Shadow(
            color: AppColors.neonGreen.withOpacity(0.3),
            blurRadius: 6,
          ),
        ),
      ],
    );
  }

  // ── Table helpers ──────────────────────────────────────────────────────────

  Widget _tableHeader(Color muted) {
    return Row(
      children: [
        Expanded(child: _th('صدر', muted)),
        Expanded(child: _th('خصر', muted)),
        Expanded(child: _th('عضل %', muted)),
        Expanded(child: _th('دهون %', muted)),
        Expanded(child: _th('وزن', muted)),
        Expanded(child: _th('تاريخ', muted)),
      ],
    );
  }

  Widget _th(String t, Color c) => Text(t,
      textAlign: TextAlign.center,
      style: GoogleFonts.tajawal(
          fontSize: 9, color: c, fontWeight: FontWeight.w600));

  Widget _tableRow(WeightEntry e, Color textColor, Color mutedColor) {
    final d = e.date;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
              child: _td(
                  e.chestCm != null ? '${e.chestCm!.toInt()}cm' : '-',
                  textColor)),
          Expanded(
              child: _td(
                  e.waistCm != null ? '${e.waistCm!.toInt()}cm' : '-',
                  textColor)),
          Expanded(child: _td('${e.musclePercent}%', textColor)),
          Expanded(child: _td('${e.fatPercent}%', textColor)),
          Expanded(child: _td('${e.weight}kg', AppColors.neonGreen)),
          Expanded(
              child: _td(
                  '${d.day}/${d.month}/${d.year.toString().substring(2)}',
                  mutedColor)),
        ],
      ),
    );
  }

  Widget _td(String t, Color c) => Text(t,
      textAlign: TextAlign.center,
      style: GoogleFonts.tajawal(
          fontSize: 9, color: c, fontWeight: FontWeight.w600));

  // ── Sheets & dialogs ───────────────────────────────────────────────────────

  void _showAddSheet(BuildContext context, FitnessProvider provider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AddMeasurementSheet(
        onSave: (entry) => provider.addWeightEntry(entry),
      ),
    );
  }

  void _confirmDeleteLast(BuildContext context, FitnessProvider provider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppColors.darkCard
            : AppColors.lightBg,
        title: Text('حذف آخر قياس؟',
            style: GoogleFonts.tajawal(fontWeight: FontWeight.w800)),
        content:
            Text('سيتم حذف آخر قياس مُسجَّل نهائياً.',
                style: GoogleFonts.tajawal()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('إلغاء', style: GoogleFonts.tajawal()),
          ),
          TextButton(
            onPressed: () {
              provider.removeWeightEntry(provider.weights.length - 1);
              Navigator.pop(ctx);
            },
            child: Text('حذف',
                style: GoogleFonts.tajawal(color: AppColors.red)),
          ),
        ],
      ),
    );
  }
}

// ─── Summary Card ─────────────────────────────────────────────────────────────
class _SummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final String emoji;
  final bool isDark;
  final bool neon;

  const _SummaryCard({
    required this.label,
    required this.value,
    required this.unit,
    required this.emoji,
    required this.isDark,
    this.neon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: neon
              ? AppColors.neonGreen.withOpacity(0.45)
              : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
        ),
        boxShadow: neon
            ? [BoxShadow(
                color: AppColors.neonGreen.withOpacity(0.08),
                blurRadius: 12)]
            : null,
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 4),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: GoogleFonts.tajawal(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: neon
                        ? AppColors.neonGreen
                        : (isDark ? AppColors.darkText : AppColors.lightText),
                  ),
                ),
                TextSpan(
                  text: unit,
                  style: GoogleFonts.tajawal(
                    fontSize: 10,
                    color: isDark
                        ? AppColors.darkTextMuted
                        : AppColors.lightTextMuted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.tajawal(
              fontSize: 8,
              color: isDark
                  ? AppColors.darkTextMuted
                  : AppColors.lightTextMuted,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ─── Weight Change Card ───────────────────────────────────────────────────────
class _WeightChangeCard extends StatelessWidget {
  final List<WeightEntry> entries;
  final bool isDark;
  final Color mutedColor;

  const _WeightChangeCard({
    required this.entries,
    required this.isDark,
    required this.mutedColor,
  });

  @override
  Widget build(BuildContext context) {
    final first = entries.first;
    final last = entries.last;
    final diff = last.weight - first.weight;
    final isLoss = diff < 0;
    final color = isLoss ? AppColors.neonGreen : AppColors.red;
    final icon = isLoss ? '📉' : '📈';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(
                '${isLoss ? '' : '+'}${diff.toStringAsFixed(1)} kg',
                style: GoogleFonts.tajawal(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: color),
              ),
            ],
          ),
          Text(
            'التغيّر منذ أول قياس',
            style: GoogleFonts.tajawal(fontSize: 12, color: mutedColor),
          ),
        ],
      ),
    );
  }
}

// ─── Add Measurement Sheet ────────────────────────────────────────────────────
class _AddMeasurementSheet extends StatefulWidget {
  final void Function(WeightEntry) onSave;

  const _AddMeasurementSheet({required this.onSave});

  @override
  State<_AddMeasurementSheet> createState() => _AddMeasurementSheetState();
}

class _AddMeasurementSheetState extends State<_AddMeasurementSheet> {
  final _weightCtrl  = TextEditingController(text: '70.0');
  final _fatCtrl     = TextEditingController(text: '15.0');
  final _muscleCtrl  = TextEditingController(text: '40.0');
  final _waistCtrl   = TextEditingController(text: '85');
  final _chestCtrl   = TextEditingController(text: '100');
  String? _error;

  @override
  void dispose() {
    _weightCtrl.dispose();
    _fatCtrl.dispose();
    _muscleCtrl.dispose();
    _waistCtrl.dispose();
    _chestCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    final weight = double.tryParse(_weightCtrl.text);
    if (weight == null || weight <= 0) {
      setState(() => _error = 'يرجى إدخال وزن صحيح');
      return;
    }
    widget.onSave(WeightEntry(
      date: DateTime.now(),
      weight: weight,
      fatPercent: double.tryParse(_fatCtrl.text) ?? 15,
      musclePercent: double.tryParse(_muscleCtrl.text) ?? 40,
      waistCm: double.tryParse(_waistCtrl.text),
      chestCm: double.tryParse(_chestCtrl.text),
    ));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: NeonBottomSheet(
        title: 'إضافة قياس حيوي جديد',
        children: [
          if (_error != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(_error!,
                  style: GoogleFonts.tajawal(
                      fontSize: 12, color: AppColors.red),
                  textAlign: TextAlign.center),
            ),
          _inputRow('الوزن *', _weightCtrl, 'كجم', isDark),
          _inputRow('نسبة الدهون', _fatCtrl, '%', isDark),
          _inputRow('نسبة العضل', _muscleCtrl, '%', isDark),
          _inputRow('محيط الخصر', _waistCtrl, 'سم', isDark),
          _inputRow('محيط الصدر', _chestCtrl, 'سم', isDark),
          const SizedBox(height: 8),
          NeonButton(label: 'حفظ القياس', onTap: _submit),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _inputRow(String label, TextEditingController ctrl, String suffix,
      bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard2 : AppColors.lightCard2,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.neonGreen.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(suffix,
                  style: GoogleFonts.tajawal(
                      fontSize: 12,
                      color: isDark
                          ? AppColors.darkTextMuted
                          : AppColors.lightTextMuted)),
              const SizedBox(width: 4),
              SizedBox(
                width: 70,
                child: TextField(
                  controller: ctrl,
                  textAlign: TextAlign.left,
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: true),
                  style: GoogleFonts.tajawal(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.neonGreen),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
          Text(label,
              style: GoogleFonts.tajawal(
                  fontSize: 13,
                  color: isDark
                      ? AppColors.darkTextMuted
                      : AppColors.lightTextMuted)),
        ],
      ),
    );
  }
}
