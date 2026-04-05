// lib/features/nutrition/nutrition_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/models/models.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../fitness_provider.dart';

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FitnessProvider>(
      builder: (context, provider, _) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final mutedColor = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
        final goals = provider.goals;

        return Scaffold(
          appBar: AppBar(
            title: const Text('التغذية'),
            actions: [
              // Goals button
              IconButton(
                onPressed: () => _showGoalsSheet(context, provider),
                icon: const Icon(Icons.tune_rounded),
                tooltip: 'أهداف التغذية',
              ),
              // Cart badge
              Stack(
                alignment: Alignment.topRight,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Icon(Icons.shopping_cart_outlined, size: 22),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: const BoxDecoration(
                        color: AppColors.neonGreen,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${provider.meals.length}',
                          style: const TextStyle(
                              fontSize: 8,
                              color: Colors.black,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // ─── Macro Rings ───
                NeonCard(
                  showNeonBorder: false,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SectionTitle('ملخص التغذية اليومي'),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          NeonRing(
                            label: 'بروتين',
                            current: provider.totalProtein,
                            total: goals.targetProtein,
                            unit: 'g',
                          ),
                          NeonRing(
                            label: 'كارب',
                            current: provider.totalCarbs,
                            total: goals.targetCarbs,
                            unit: 'g',
                          ),
                          NeonRing(
                            label: 'دهون',
                            current: provider.totalFat,
                            total: goals.targetFat,
                            unit: 'g',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                // ─── Calories Card ───
                NeonCard(
                  showNeonBorder: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${provider.totalCalories.toInt()} / ${goals.targetCalories.toInt()} kcal',
                            style: GoogleFonts.tajawal(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.neonGreen),
                          ),
                          Text('السعرات اليومية',
                              style: GoogleFonts.tajawal(
                                  fontSize: 12, color: mutedColor)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      NeonProgressBar(
                        value: (provider.totalCalories / goals.targetCalories).clamp(0, 1),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'متبقي ${provider.remainingCalories.toInt()} kcal',
                            style: GoogleFonts.tajawal(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: provider.remainingCalories > 0
                                    ? AppColors.neonGreen
                                    : AppColors.red),
                          ),
                          Text(
                            '${((provider.totalCalories / goals.targetCalories) * 100).toInt()}%',
                            style: GoogleFonts.tajawal(
                                fontSize: 11, color: mutedColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // ─── Add Button ───
                NeonButton(
                  label: '+ إضافة وجبة جديدة',
                  onTap: () => _showAddMealSheet(context, provider),
                ),
                const SizedBox(height: 16),

                // ─── Meals Log ───
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => _confirmClearMeals(context, provider),
                      child: Text(
                        'مسح الكل',
                        style: GoogleFonts.tajawal(
                            fontSize: 11,
                            color: AppColors.red,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SectionTitle('سجل وجبات اليوم'),
                  ],
                ),
                const SizedBox(height: 8),

                if (provider.meals.isEmpty)
                  _EmptyState(
                    icon: '🍽',
                    message: 'لم تُسجَّل وجبات بعد.\nاضغط "إضافة وجبة" للبدء.',
                    isDark: isDark,
                  )
                else
                  ...provider.meals.asMap().entries.map((entry) {
                    return _MealCard(
                      meal: entry.value,
                      onRemove: () => provider.removeMeal(entry.key),
                    );
                  }),

                const SizedBox(height: 16),

                // ─── Suggested ───
                const SectionTitle('أطعمة مقترحة'),
                const SizedBox(height: 8),
                ..._suggested.map((food) => _SuggestedCard(
                      food: food,
                      onAdd: () => provider.addMeal(MealEntry(
                        name: food.name,
                        calories: food.calories,
                        protein: food.protein,
                        carbs: food.carbs,
                        fat: food.fat,
                        grams: 100,
                        time: DateTime.now(),
                      )),
                    )),
                const SizedBox(height: 80),
              ],
            ),
          ),
          // FAB on the LEFT side
          floatingActionButtonLocation:
              FloatingActionButtonLocation.startFloat,
          floatingActionButton: NeonFAB(
            onTap: () => _showAddMealSheet(context, provider),
          ),
        );
      },
    );
  }

  // ── Sheets ─────────────────────────────────────────────────────────────────

  void _showAddMealSheet(BuildContext context, FitnessProvider provider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AddMealSheet(
        onAdd: (meal) => provider.addMeal(meal),
      ),
    );
  }

  void _showGoalsSheet(BuildContext context, FitnessProvider provider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _GoalsSheet(
        current: provider.goals,
        onSave: (goals) => provider.updateGoals(goals),
      ),
    );
  }

  void _confirmClearMeals(BuildContext context, FitnessProvider provider) {
    if (provider.meals.isEmpty) return;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppColors.darkCard
            : AppColors.lightBg,
        title: Text('مسح الوجبات؟',
            style: GoogleFonts.tajawal(fontWeight: FontWeight.w800)),
        content: Text('سيتم حذف جميع وجبات اليوم.',
            style: GoogleFonts.tajawal()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('إلغاء', style: GoogleFonts.tajawal()),
          ),
          TextButton(
            onPressed: () {
              provider.clearTodayMeals();
              Navigator.pop(ctx);
            },
            child: Text('مسح',
                style: GoogleFonts.tajawal(color: AppColors.red)),
          ),
        ],
      ),
    );
  }

  // ── Suggested meals list ───────────────────────────────────────────────────
  static final List<_SuggestedFood> _suggested = [
    _SuggestedFood('أرز أبيض', 180, 4, 38, 0.5),
    _SuggestedFood('سلطة خضراء', 120, 4, 12, 6),
    _SuggestedFood('تفاحة', 95, 0.5, 25, 0.3),
    _SuggestedFood('موز', 105, 1.3, 27, 0.4),
    _SuggestedFood('زبادي헬', 100, 10, 12, 0.5),
    _SuggestedFood('بيض مسلوق', 140, 12, 1, 10),
  ];
}

// ─── Meal Card ────────────────────────────────────────────────────────────────
class _MealCard extends StatelessWidget {
  final MealEntry meal;
  final VoidCallback onRemove;

  const _MealCard({required this.meal, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final h = meal.time.hour;
    final m = meal.time.minute.toString().padLeft(2, '0');
    final ampm = h < 12 ? 'ص' : 'م';
    final h12 = h > 12 ? h - 12 : (h == 0 ? 12 : h);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          right: const BorderSide(color: AppColors.neonGreen, width: 2.5),
          top: BorderSide(
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
          bottom: BorderSide(
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
          left: BorderSide(
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
        ),
      ),
      child: Row(
        children: [
          RemoveButton(onTap: onRemove),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  meal.name,
                  style: GoogleFonts.tajawal(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppColors.darkText : AppColors.lightText),
                ),
                const SizedBox(height: 2),
                Text(
                  '${meal.grams.toInt()}g  ·  ${meal.calories.toInt()} kcal  ·  ${meal.protein.toInt()}p  ${meal.carbs.toInt()}c  ${meal.fat.toInt()}f',
                  style: GoogleFonts.tajawal(
                      fontSize: 9,
                      color: isDark
                          ? AppColors.darkTextMuted
                          : AppColors.lightTextMuted),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$h12:$m $ampm',
            style: GoogleFonts.tajawal(
                fontSize: 11,
                color:
                    isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
          ),
        ],
      ),
    );
  }
}

// ─── Suggested Card ───────────────────────────────────────────────────────────
class _SuggestedCard extends StatelessWidget {
  final _SuggestedFood food;
  final VoidCallback onAdd;

  const _SuggestedCard({required this.food, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onAdd,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: AppColors.neonGreen,
                borderRadius: BorderRadius.circular(8),
                boxShadow: AppTheme.neonGlowList(blur: 6, opacity: 0.25),
              ),
              child: const Icon(Icons.add, color: Colors.black, size: 18),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                food.name,
                style: GoogleFonts.tajawal(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color:
                        isDark ? AppColors.darkText : AppColors.lightText),
              ),
              Text(
                '${food.calories.toInt()} kcal  ·  ${food.protein.toInt()}p  ${food.carbs.toInt()}c  ${food.fat.toInt()}f',
                style: GoogleFonts.tajawal(
                    fontSize: 9,
                    color: isDark
                        ? AppColors.darkTextMuted
                        : AppColors.lightTextMuted),
              ),
            ],
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
          Text(
            message,
            style: GoogleFonts.tajawal(
                fontSize: 13,
                color: isDark
                    ? AppColors.darkTextMuted
                    : AppColors.lightTextMuted),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ─── Data model ───────────────────────────────────────────────────────────────
class _SuggestedFood {
  final String name;
  final double calories, protein, carbs, fat;
  _SuggestedFood(this.name, this.calories, this.protein, this.carbs, this.fat);
}

// ─── Add Meal Sheet ───────────────────────────────────────────────────────────
class _AddMealSheet extends StatefulWidget {
  final void Function(MealEntry) onAdd;
  const _AddMealSheet({required this.onAdd});

  @override
  State<_AddMealSheet> createState() => _AddMealSheetState();
}

class _AddMealSheetState extends State<_AddMealSheet> {
  final _nameCtrl    = TextEditingController();
  final _gramsCtrl   = TextEditingController(text: '100');
  final _calCtrl     = TextEditingController();
  final _proteinCtrl = TextEditingController(text: '0');
  final _carbsCtrl   = TextEditingController(text: '0');
  final _fatCtrl     = TextEditingController(text: '0');
  String? _error;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _gramsCtrl.dispose();
    _calCtrl.dispose();
    _proteinCtrl.dispose();
    _carbsCtrl.dispose();
    _fatCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_nameCtrl.text.trim().isEmpty) {
      setState(() => _error = 'يرجى إدخال اسم الوجبة');
      return;
    }
    if (_calCtrl.text.trim().isEmpty) {
      setState(() => _error = 'يرجى إدخال السعرات الحرارية');
      return;
    }
    widget.onAdd(MealEntry(
      name: _nameCtrl.text.trim(),
      calories: double.tryParse(_calCtrl.text) ?? 0,
      protein: double.tryParse(_proteinCtrl.text) ?? 0,
      carbs: double.tryParse(_carbsCtrl.text) ?? 0,
      fat: double.tryParse(_fatCtrl.text) ?? 0,
      grams: double.tryParse(_gramsCtrl.text) ?? 100,
      time: DateTime.now(),
    ));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: NeonBottomSheet(
        title: 'إضافة وجبة جديدة',
        children: [
          if (_error != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(_error!,
                  style: GoogleFonts.tajawal(
                      fontSize: 12, color: AppColors.red),
                  textAlign: TextAlign.center),
            ),
          _field('اسم الوجبة *', _nameCtrl, isDark),
          _field('الكمية (g)', _gramsCtrl, isDark, isNum: true),
          _field('السعرات الحرارية *', _calCtrl, isDark, isNum: true),
          _field('البروتين (g)', _proteinCtrl, isDark, isNum: true),
          _field('الكربوهيدرات (g)', _carbsCtrl, isDark, isNum: true),
          _field('الدهون (g)', _fatCtrl, isDark, isNum: true),
          const SizedBox(height: 8),
          NeonButton(label: 'إضافة للسجل', onTap: _submit),
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
            isNum ? const TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
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

// ─── Goals Sheet ──────────────────────────────────────────────────────────────
class _GoalsSheet extends StatefulWidget {
  final UserGoals current;
  final void Function(UserGoals) onSave;

  const _GoalsSheet({required this.current, required this.onSave});

  @override
  State<_GoalsSheet> createState() => _GoalsSheetState();
}

class _GoalsSheetState extends State<_GoalsSheet> {
  late TextEditingController _calCtrl;
  late TextEditingController _proteinCtrl;
  late TextEditingController _carbsCtrl;
  late TextEditingController _fatCtrl;

  @override
  void initState() {
    super.initState();
    _calCtrl     = TextEditingController(text: widget.current.targetCalories.toInt().toString());
    _proteinCtrl = TextEditingController(text: widget.current.targetProtein.toInt().toString());
    _carbsCtrl   = TextEditingController(text: widget.current.targetCarbs.toInt().toString());
    _fatCtrl     = TextEditingController(text: widget.current.targetFat.toInt().toString());
  }

  @override
  void dispose() {
    _calCtrl.dispose();
    _proteinCtrl.dispose();
    _carbsCtrl.dispose();
    _fatCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: NeonBottomSheet(
        title: 'أهداف التغذية اليومية',
        children: [
          _goalRow('هدف السعرات', _calCtrl, 'kcal', isDark),
          _goalRow('هدف البروتين', _proteinCtrl, 'g', isDark),
          _goalRow('هدف الكربوهيدرات', _carbsCtrl, 'g', isDark),
          _goalRow('هدف الدهون', _fatCtrl, 'g', isDark),
          const SizedBox(height: 8),
          NeonButton(
            label: 'حفظ الأهداف',
            onTap: () {
              widget.onSave(UserGoals(
                targetCalories: double.tryParse(_calCtrl.text) ?? 2300,
                targetProtein:  double.tryParse(_proteinCtrl.text) ?? 180,
                targetCarbs:    double.tryParse(_carbsCtrl.text) ?? 250,
                targetFat:      double.tryParse(_fatCtrl.text) ?? 70,
              ));
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _goalRow(String label, TextEditingController ctrl, String unit,
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
              Text(unit,
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
                  keyboardType: TextInputType.number,
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
