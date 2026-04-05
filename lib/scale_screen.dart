// lib/features/scale/scale_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../app_theme.dart';
import '../models.dart';
import '../shared_widgets.dart';
import 'add_measurement_sheet.dart';

class ScaleScreen extends StatefulWidget {
  const ScaleScreen({super.key});

  @override
  State<ScaleScreen> createState() => _ScaleScreenState();
}

class _ScaleScreenState extends State<ScaleScreen> {
  List<WeightEntry> _entries = List.from(SampleData.weights);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mutedColor = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;

    return Scaffold(
      appBar: AppBar(
        title: const Text('الميزان'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {},
          ),
        ],
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // ─── Chart ───
            NeonCard(
              padding: const EdgeInsets.fromLTRB(12, 14, 14, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('منحنى الوزن الشهري',
                      style: GoogleFonts.tajawal(
                          fontSize: 13, fontWeight: FontWeight.w700, color: textColor)),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 140,
                    child: LineChart(_buildChart(isDark)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ─── Add Button ───
            NeonButton(
              label: 'إضافة قياس جديد',
              onTap: () => _showAddSheet(context),
              prefix: const Icon(Icons.add, color: Colors.black, size: 18),
            ),
            const SizedBox(height: 16),

            // ─── Measurements Table ───
            const SectionTitle('سجل القياسات الحيوية'),
            const SizedBox(height: 8),
            NeonCard(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  // Header
                  _tableHeader(mutedColor),
                  const Divider(height: 12),
                  ..._entries.reversed.map((e) => _tableRow(e, textColor, mutedColor)),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  LineChartData _buildChart(bool isDark) {
    final spots = _entries.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.weight);
    }).toList();

    final minY = _entries.map((e) => e.weight).reduce((a, b) => a < b ? a : b) - 1;
    final maxY = _entries.map((e) => e.weight).reduce((a, b) => a > b ? a : b) + 1;

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
                color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
              ),
            ),
          ),
        ),
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 20,
            getTitlesWidget: (v, meta) {
              final idx = v.toInt();
              if (idx < 0 || idx >= _entries.length) return const SizedBox();
              final date = _entries[idx].date;
              return Text(
                '${date.day}/${date.month}',
                style: GoogleFonts.tajawal(
                  fontSize: 8,
                  color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
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
                AppColors.neonGreen.withOpacity(0.25),
                AppColors.neonGreen.withOpacity(0.0),
              ],
            ),
          ),
          shadow: Shadow(
            color: AppColors.neonGreen.withOpacity(0.4),
            blurRadius: 8,
          ),
        ),
      ],
    );
  }

  Widget _tableHeader(Color muted) {
    return Row(
      children: [
        Expanded(child: _th('محيط الصدر', muted)),
        Expanded(child: _th('محيط الخصر', muted)),
        Expanded(child: _th('عضل %', muted)),
        Expanded(child: _th('دهون %', muted)),
        Expanded(child: _th('الوزن', muted)),
        Expanded(child: _th('التاريخ', muted)),
      ],
    );
  }

  Widget _th(String t, Color c) => Text(t,
      textAlign: TextAlign.center,
      style: GoogleFonts.tajawal(fontSize: 9, color: c, fontWeight: FontWeight.w600));

  Widget _tableRow(WeightEntry e, Color text, Color muted) {
    final d = e.date;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: _td('${e.chestCm?.toInt() ?? '-'} cm', text)),
          Expanded(child: _td('${e.waistCm?.toInt() ?? '-'} cm', text)),
          Expanded(child: _td('${e.musclePercent}%', text)),
          Expanded(child: _td('${e.fatPercent}%', text)),
          Expanded(
              child: _td('${e.weight} kg', AppColors.neonGreen)),
          Expanded(
              child: _td('${d.day}/${d.month}/${d.year.toString().substring(2)}', muted)),
        ],
      ),
    );
  }

  Widget _td(String t, Color c) => Text(t,
      textAlign: TextAlign.center,
      style: GoogleFonts.tajawal(fontSize: 9, color: c, fontWeight: FontWeight.w600));

  void _showAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddMeasurementSheet(
        onSave: (entry) => setState(() => _entries.add(entry)),
      ),
    );
  }
}
