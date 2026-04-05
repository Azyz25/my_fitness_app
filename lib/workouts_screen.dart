// lib/features/workouts/workouts_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/models/models.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../fitness_provider.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({super.key});

  static const _completedDays = [true, false, true, true, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Consumer<FitnessProvider>(
      builder: (context, provider, _) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final mutedColor =
            isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
        final exercises = provider.exercises;

        return Scaffold(
          appBar: AppBar(
            title: const Text('التمارين'),
            leading: const BackButton(),
            actions: [
              // Reset all sets
              IconButton(
                onPressed: exercises.isEmpty
                    ? null
                    : () => _confirmReset(context, provider),
                icon: const Icon(Icons.refresh_rounded, size: 20),
                tooltip: 'إعادة تعيين الجولات',
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // ─── Weekly Plan ───
                NeonCard(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SectionTitle('خطة التمارين الأسبوعية'),
                      const SizedBox(height: 12),
                      const WeekDayStrip(
                        todayIndex: 3,
                        completedDays: _completedDays,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            exercises.isEmpty
                                ? '0%'
                                : '${((provider.completedExercises / exercises.length) * 100).toInt()}% تم الإنجاز',
                            style: GoogleFonts.tajawal(
                                fontSize: 11, color: mutedColor),
                          ),
                          Text(
                            '${provider.completedExercises}/${exercises.length} مكتملة',
                            style: GoogleFonts.tajawal(
                                fontSize: 11,
                                color: AppColors.neonGreen,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      NeonProgressBar(
                        value: exercises.isEmpty
                            ? 0
                            : provider.completedExercises / exercises.length,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // ─── Add Button ───
                NeonButton(
                  label: '+ إضافة تمرين جديد',
                  onTap: () => _showAddExerciseSheet(context, provider),
                ),
                const SizedBox(height: 16),

                // ─── Today's Exercises ───
                const SectionTitle('تمارين اليوم'),
                const SizedBox(height: 8),

                if (exercises.isEmpty)
                  _EmptyState(
                    icon: '🏋',
                    message: 'لم تُضَف تمارين بعد.\nاضغط "إضافة تمرين" للبدء.',
                    isDark: isDark,
                  )
                else
                  ...exercises.asMap().entries.map((entry) {
                    return _ExerciseCard(
                      exercise: entry.value,
                      onStartSet: () =>
                          _showSetSheet(context, provider, entry.key),
                      onRemove: () => provider.removeExercise(entry.key),
                    );
                  }),

                const SizedBox(height: 80),
              ],
            ),
          ),
          // FAB on the LEFT side
          floatingActionButtonLocation:
              FloatingActionButtonLocation.startFloat,
          floatingActionButton: NeonFAB(
            onTap: () => _showAddExerciseSheet(context, provider),
          ),
        );
      },
    );
  }

  // ── Sheets & dialogs ───────────────────────────────────────────────────────

  void _showSetSheet(
      BuildContext context, FitnessProvider provider, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _SetDetailSheet(
        exercise: provider.exercises[index],
        onLogSet: () => provider.logSet(index),
        onEndWorkout: () => Navigator.pop(context),
      ),
    );
  }

  void _showAddExerciseSheet(
      BuildContext context, FitnessProvider provider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AddExerciseSheet(
        onAdd: (ex) => provider.addExercise(ex),
      ),
    );
  }

  void _confirmReset(BuildContext context, FitnessProvider provider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppColors.darkCard
            : AppColors.lightBg,
        title: Text('إعادة تعيين؟',
            style: GoogleFonts.tajawal(fontWeight: FontWeight.w800)),
        content:
            Text('سيتم إعادة تعيين جميع الجولات إلى الصفر.',
                style: GoogleFonts.tajawal()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('إلغاء', style: GoogleFonts.tajawal()),
          ),
          TextButton(
            onPressed: () {
              provider.resetExercises();
              Navigator.pop(ctx);
            },
            child: Text('إعادة تعيين',
                style: GoogleFonts.tajawal(color: AppColors.neonGreen)),
          ),
        ],
      ),
    );
  }
}

// ─── Empty State ──────────────────────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  final String icon;
  final String message;
  final bool isDark;
  const _EmptyState(
      {required this.icon, required this.message, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 40)),
          const SizedBox(height: 12),
          Text(message,
              style: GoogleFonts.tajawal(
                  fontSize: 13,
                  color: isDark
                      ? AppColors.darkTextMuted
                      : AppColors.lightTextMuted),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

// ─── Exercise Card ────────────────────────────────────────────────────────────
class _ExerciseCard extends StatelessWidget {
  final ExerciseEntry exercise;
  final VoidCallback onStartSet;
  final VoidCallback onRemove;

  const _ExerciseCard({
    required this.exercise,
    required this.onStartSet,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isComplete = exercise.completedSets >= exercise.sets;

    return GestureDetector(
      onTap: onStartSet,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isComplete
                ? AppColors.neonGreen.withOpacity(0.55)
                : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: isComplete ? 1.5 : 1,
          ),
          boxShadow: isComplete
              ? [BoxShadow(
                  color: AppColors.neonGreen.withOpacity(0.07),
                  blurRadius: 12)]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Remove button (small)
                GestureDetector(
                  onTap: onRemove,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.darkCard2
                          : AppColors.lightCard2,
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(
                          color: AppColors.red.withOpacity(0.4)),
                    ),
                    child: const Icon(Icons.delete_outline,
                        size: 14, color: AppColors.red),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      exercise.name,
                      style: GoogleFonts.tajawal(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: isDark
                            ? AppColors.darkText
                            : AppColors.lightText,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.darkCard2
                            : AppColors.lightCard2,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                          child: Text(exercise.emoji,
                              style: const TextStyle(fontSize: 18))),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Stats row
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _statChip('${exercise.weightKg.toInt()} kg', isDark),
                const SizedBox(width: 8),
                _statChip('${exercise.reps} تكرار', isDark),
                const SizedBox(width: 8),
                _statChip('${exercise.sets} مجموعات', isDark),
              ],
            ),
            const SizedBox(height: 10),

            // Footer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Action button
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    color: isComplete
                        ? AppColors.neonGreenDim
                        : AppColors.neonGreen,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: isComplete
                        ? null
                        : AppTheme.neonGlowList(blur: 7, opacity: 0.25),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isComplete
                            ? Icons.check_rounded
                            : Icons.timer_outlined,
                        size: 14,
                        color: isComplete
                            ? AppColors.neonGreen
                            : Colors.black,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isComplete ? 'مكتمل' : 'بدء الجولة',
                        style: GoogleFonts.tajawal(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: isComplete
                              ? AppColors.neonGreen
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                // Set dots
                SetDots(
                    total: exercise.sets,
                    completed: exercise.completedSets),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statChip(String label, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard2 : AppColors.lightCard2,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: GoogleFonts.tajawal(
          fontSize: 11,
          color: AppColors.neonGreen,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ─── Set Detail Sheet ─────────────────────────────────────────────────────────
class _SetDetailSheet extends StatefulWidget {
  final ExerciseEntry exercise;
  final VoidCallback onLogSet;
  final VoidCallback onEndWorkout;

  const _SetDetailSheet({
    required this.exercise,
    required this.onLogSet,
    required this.onEndWorkout,
  });

  @override
  State<_SetDetailSheet> createState() => _SetDetailSheetState();
}

class _SetDetailSheetState extends State<_SetDetailSheet> {
  late double _weight;
  late int _reps;

  @override
  void initState() {
    super.initState();
    _weight = widget.exercise.weightKg;
    _reps = widget.exercise.reps;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentSet =
        (widget.exercise.completedSets + 1).clamp(1, widget.exercise.sets);

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: NeonBottomSheet(
        title: 'تفاصيل جولة – ${widget.exercise.muscleGroup}',
        children: [
          NeonInputField(
              label: 'اسم التمرين', value: widget.exercise.name),
          NeonInputField(
            label: 'الجولة الحالية',
            value: '$currentSet / ${widget.exercise.sets}',
          ),
          _stepperRow(
            'الوزن المستخدم (kg)',
            _weight.toStringAsFixed(1),
            onMinus: () =>
                setState(() => _weight = (_weight - 2.5).clamp(0, 500)),
            onPlus: () => setState(() => _weight += 2.5),
            isDark: isDark,
          ),
          _stepperRow(
            'التكرار المنجز',
            '$_reps',
            onMinus: () =>
                setState(() => _reps = (_reps - 1).clamp(1, 100)),
            onPlus: () => setState(() => _reps++),
            isDark: isDark,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: NeonButton(
                  label: 'إغلاق',
                  outlined: true,
                  height: 44,
                  onTap: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: NeonButton(
                  label: 'تسجيل جولة',
                  height: 44,
                  onTap: () {
                    widget.onLogSet();
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              widget.onEndWorkout();
              Navigator.pop(context);
            },
            child: Container(
              width: double.infinity,
              height: 44,
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard2 : AppColors.lightCard2,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: AppColors.red.withOpacity(0.5)),
              ),
              child: Center(
                child: Text(
                  'إنهاء التمرين',
                  style: GoogleFonts.tajawal(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.red,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _stepperRow(
    String label,
    String value, {
    required VoidCallback onMinus,
    required VoidCallback onPlus,
    required bool isDark,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard2 : AppColors.lightCard2,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.neonGreen.withOpacity(0.35)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: onPlus,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppColors.neonGreen,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: const Icon(Icons.add, size: 16, color: Colors.black),
                ),
              ),
              const SizedBox(width: 10),
              Text(value,
                  style: GoogleFonts.tajawal(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.neonGreen)),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: onMinus,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCard : AppColors.lightCard,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                        color: AppColors.neonGreen.withOpacity(0.4)),
                  ),
                  child: Icon(Icons.remove,
                      size: 16,
                      color: isDark
                          ? AppColors.darkText
                          : AppColors.lightText),
                ),
              ),
            ],
          ),
          Text(label,
              style: GoogleFonts.tajawal(
                  fontSize: 12,
                  color: isDark
                      ? AppColors.darkTextMuted
                      : AppColors.lightTextMuted)),
        ],
      ),
    );
  }
}

// ─── Add Exercise Sheet ───────────────────────────────────────────────────────
class _AddExerciseSheet extends StatefulWidget {
  final void Function(ExerciseEntry) onAdd;
  const _AddExerciseSheet({required this.onAdd});

  @override
  State<_AddExerciseSheet> createState() => _AddExerciseSheetState();
}

class _AddExerciseSheetState extends State<_AddExerciseSheet> {
  final _nameCtrl   = TextEditingController();
  final _setsCtrl   = TextEditingController(text: '3');
  final _repsCtrl   = TextEditingController(text: '12');
  final _weightCtrl = TextEditingController(text: '60');
  String _selectedEmoji = '💪';
  String? _error;

  static const _emojis = ['💪', '🦵', '🏋', '🤸', '🏃', '🚴', '🧘'];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _setsCtrl.dispose();
    _repsCtrl.dispose();
    _weightCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_nameCtrl.text.trim().isEmpty) {
      setState(() => _error = 'يرجى إدخال اسم التمرين');
      return;
    }
    widget.onAdd(ExerciseEntry(
      name: _nameCtrl.text.trim(),
      muscleGroup: _nameCtrl.text.trim(),
      sets: int.tryParse(_setsCtrl.text) ?? 3,
      reps: int.tryParse(_repsCtrl.text) ?? 12,
      weightKg: double.tryParse(_weightCtrl.text) ?? 0,
      emoji: _selectedEmoji,
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
        title: 'إضافة تمرين جديد',
        children: [
          if (_error != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(_error!,
                  style: GoogleFonts.tajawal(
                      fontSize: 12, color: AppColors.red),
                  textAlign: TextAlign.center),
            ),
          // Emoji picker
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              children: _emojis.map((e) {
                final selected = e == _selectedEmoji;
                return GestureDetector(
                  onTap: () => setState(() => _selectedEmoji = e),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    margin: const EdgeInsets.only(right: 8),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.neonGreenDim
                          : (isDark
                              ? AppColors.darkCard2
                              : AppColors.lightCard2),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: selected
                            ? AppColors.neonGreen
                            : (isDark
                                ? AppColors.darkBorder
                                : AppColors.lightBorder),
                      ),
                    ),
                    child: Center(
                        child: Text(e,
                            style: const TextStyle(fontSize: 20))),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 10),
          _field('اسم التمرين *', _nameCtrl, isDark),
          _field('عدد المجموعات', _setsCtrl, isDark, isNum: true),
          _field('عدد التكرارات', _repsCtrl, isDark, isNum: true),
          _field('الوزن (kg)', _weightCtrl, isDark, isNum: true),
          const SizedBox(height: 8),
          NeonButton(label: 'إضافة التمرين', onTap: _submit),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _field(String label, TextEditingController ctrl, bool isDark,
      {bool isNum = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard2 : AppColors.lightCard2,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.neonGreen.withOpacity(0.35)),
      ),
      child: TextField(
        controller: ctrl,
        textAlign: TextAlign.right,
        keyboardType:
            isNum ? TextInputType.number : TextInputType.text,
        textDirection: TextDirection.rtl,
        style: GoogleFonts.tajawal(
            fontSize: 13,
            color: isDark ? AppColors.darkText : AppColors.lightText),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: GoogleFonts.tajawal(
              fontSize: 12,
              color: isDark
                  ? AppColors.darkTextMuted
                  : AppColors.lightTextMuted),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
      ),
    );
  }
}
