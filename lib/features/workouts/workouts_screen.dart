// lib/features/workouts/workouts_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../core/state/app_state.dart';
import '../../shared/models/models.dart';
import '../../shared/widgets/shared_widgets.dart';

class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({super.key});

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  List<ExerciseEntry> _exercises = List.from(SampleData.exercises);

  final List<bool> _completedDays = [true, false, true, true, false, false, false];

  int get _completedCount => _exercises.where((e) => e.completedSets >= e.sets).length;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mutedColor = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

    return Scaffold(
      appBar: AppBar(
        title: const Text('التمارين'),
        leading: const BackButton(),
        actions: [
          IconButton(icon: const Icon(Icons.person_outline), onPressed: () {}),
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
                  WeekDayStrip(
                    todayIndex: 3, // Thursday
                    completedDays: _completedDays,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '70% تم الإنجاز',
                        style: GoogleFonts.tajawal(fontSize: 11, color: mutedColor),
                      ),
                      const SizedBox.shrink(),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const NeonProgressBar(value: 0.7),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ─── Add Exercise Button ───
            NeonButton(
              label: '+ إضافة تمرين جديد',
              onTap: () => _showAddExerciseSheet(context),
            ),
            const SizedBox(height: 16),

            // ─── Today's Exercises ───
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$_completedCount/${_exercises.length} مكتملة',
                  style: GoogleFonts.tajawal(
                      fontSize: 11, color: AppColors.neonGreen, fontWeight: FontWeight.w600),
                ),
                const SectionTitle('تمارين اليوم'),
              ],
            ),
            const SizedBox(height: 8),

            ..._exercises.asMap().entries.map((e) {
              return _ExerciseCard(
                exercise: e.value,
                onStartSet: () => _showSetSheet(context, e.key),
                onTap: () => _showSetSheet(context, e.key),
              );
            }),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  void _showSetSheet(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _SetDetailSheet(
        exercise: _exercises[index],
        onLogSet: () {
          setState(() {
            if (_exercises[index].completedSets < _exercises[index].sets) {
              _exercises[index] = ExerciseEntry(
                name: _exercises[index].name,
                muscleGroup: _exercises[index].muscleGroup,
                sets: _exercises[index].sets,
                reps: _exercises[index].reps,
                weightKg: _exercises[index].weightKg,
                completedSets: _exercises[index].completedSets + 1,
                emoji: _exercises[index].emoji,
              );
            }
          });
        },
        onEndWorkout: () => Navigator.pop(context),
      ),
    );
  }

  void _showAddExerciseSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AddExerciseSheet(
        onAdd: (ex) => setState(() => _exercises.add(ex)),
      ),
    );
  }
}

// ─── Exercise Card ────────────────────────────────────────────────────────────
class _ExerciseCard extends StatelessWidget {
  final ExerciseEntry exercise;
  final VoidCallback onStartSet;
  final VoidCallback onTap;

  const _ExerciseCard({
    required this.exercise,
    required this.onStartSet,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isComplete = exercise.completedSets >= exercise.sets;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isComplete
                ? AppColors.neonGreen.withOpacity(0.6)
                : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: isComplete ? 1.5 : 1,
          ),
          boxShadow: isComplete
              ? [BoxShadow(color: AppColors.neonGreen.withOpacity(0.08), blurRadius: 12)]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCard2 : AppColors.lightCard2,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(child: Text(exercise.emoji, style: const TextStyle(fontSize: 18))),
                ),
                Text(
                  exercise.name,
                  style: GoogleFonts.tajawal(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                  ),
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

            // Footer: dots + button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Start button
                GestureDetector(
                  onTap: onStartSet,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                      color: isComplete ? AppColors.neonGreenDim : AppColors.neonGreen,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: isComplete ? null : AppTheme.neonGlowList(blur: 8, opacity: 0.3),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isComplete ? Icons.check : Icons.timer_outlined,
                          size: 14,
                          color: isComplete ? AppColors.neonGreen : Colors.black,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          isComplete ? 'مكتمل' : 'بدء',
                          style: GoogleFonts.tajawal(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: isComplete ? AppColors.neonGreen : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Set dots
                SetDots(total: exercise.sets, completed: exercise.completedSets),
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
    final currentSet = (widget.exercise.completedSets + 1).clamp(1, widget.exercise.sets);

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: NeonBottomSheet(
        title: 'تفاصيل جولة تمرين ${widget.exercise.muscleGroup}',
        children: [
          NeonInputField(label: 'اسم التمرين', value: widget.exercise.name),
          NeonInputField(
              label: 'الجولة الحالية',
              value: '$currentSet/${widget.exercise.sets}'),
          // Weight stepper
          _stepperRow(
            'الوزن المستخدم (kg)',
            _weight.toStringAsFixed(1),
            onMinus: () => setState(() => _weight = (_weight - 2.5).clamp(0, 500)),
            onPlus: () => setState(() => _weight += 2.5),
            isDark: isDark,
          ),
          // Reps stepper
          _stepperRow(
            'التكرار المنجز',
            '$_reps',
            onMinus: () => setState(() => _reps = (_reps - 1).clamp(1, 100)),
            onPlus: () => setState(() => _reps++),
            isDark: isDark,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: NeonButton(
                  label: 'إنهاء الجولة',
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
            onTap: widget.onEndWorkout,
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

  Widget _stepperRow(String label, String value,
      {required VoidCallback onMinus, required VoidCallback onPlus, required bool isDark}) {
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
          // Stepper
          Row(
            children: [
              GestureDetector(
                onTap: onPlus,
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: AppColors.neonGreen,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.add, size: 16, color: Colors.black),
                ),
              ),
              const SizedBox(width: 8),
              Text(value,
                  style: GoogleFonts.tajawal(
                      fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.neonGreen)),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: onMinus,
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCard : AppColors.lightCard,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.neonGreen.withOpacity(0.4)),
                  ),
                  child: Icon(Icons.remove, size: 16,
                      color: isDark ? AppColors.darkText : AppColors.lightText),
                ),
              ),
            ],
          ),
          Text(label,
              style: GoogleFonts.tajawal(
                  fontSize: 12,
                  color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted)),
        ],
      ),
    );
  }
}

// ─── Add Exercise Sheet ───────────────────────────────────────────────────────
class _AddExerciseSheet extends StatefulWidget {
  final Function(ExerciseEntry) onAdd;

  const _AddExerciseSheet({required this.onAdd});

  @override
  State<_AddExerciseSheet> createState() => _AddExerciseSheetState();
}

class _AddExerciseSheetState extends State<_AddExerciseSheet> {
  final _nameCtrl = TextEditingController();
  final _setsCtrl = TextEditingController(text: '3');
  final _repsCtrl = TextEditingController(text: '12');
  final _weightCtrl = TextEditingController(text: '60');

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: NeonBottomSheet(
        title: 'إضافة تمرين جديد',
        children: [
          _field('اسم التمرين', _nameCtrl, isDark),
          _field('عدد المجموعات', _setsCtrl, isDark, isNum: true),
          _field('عدد التكرارات', _repsCtrl, isDark, isNum: true),
          _field('الوزن (kg)', _weightCtrl, isDark, isNum: true),
          const SizedBox(height: 8),
          NeonButton(
            label: 'إضافة التمرين',
            onTap: () {
              if (_nameCtrl.text.isNotEmpty) {
                widget.onAdd(ExerciseEntry(
                  name: _nameCtrl.text,
                  muscleGroup: _nameCtrl.text,
                  sets: int.tryParse(_setsCtrl.text) ?? 3,
                  reps: int.tryParse(_repsCtrl.text) ?? 12,
                  weightKg: double.tryParse(_weightCtrl.text) ?? 60,
                  emoji: '💪',
                ));
                Navigator.pop(context);
              }
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _field(String label, TextEditingController ctrl, bool isDark, {bool isNum = false}) {
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
        keyboardType: isNum ? TextInputType.number : TextInputType.text,
        textDirection: TextDirection.rtl,
        style: GoogleFonts.tajawal(
            fontSize: 13, color: isDark ? AppColors.darkText : AppColors.lightText),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: GoogleFonts.tajawal(
              fontSize: 12, color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
      ),
    );
  }
}
