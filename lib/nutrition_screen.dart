// lib/features/nutrition/nutrition_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/models/models.dart';
import '../../shared/widgets/shared_widgets.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  List<MealEntry> _meals = List.from(SampleData.meals);

  double get _totalProtein => _meals.fold(0, (s, m) => s + m.protein);
  double get _totalCarbs => _meals.fold(0, (s, m) => s + m.carbs);
  double get _totalFat => _meals.fold(0, (s, m) => s + m.fat);
  double get _totalCalories => _meals.fold(0, (s, m) => s + m.calories);

  final List<_SuggestedFood> _suggested = [
    _SuggestedFood('أرز أبيض', 180, 4, 38, 0.5),
    _SuggestedFood('سلطة خضراء', 120, 4, 12, 6),
    _SuggestedFood('تفاحة', 95, 0.5, 25, 0.3),
    _SuggestedFood('موز', 105, 1.3, 27, 0.4),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mutedColor = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

    return Scaffold(
      appBar: AppBar(
        title: const Text('التغذية'),
        actions: [
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
                    child: Text('${_meals.length}',
                        style: const TextStyle(fontSize: 8, color: Colors.black, fontWeight: FontWeight.w900)),
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
                      NeonRing(label: 'بروتين', current: _totalProtein, total: 180, unit: 'g'),
                      NeonRing(label: 'كارب', current: _totalCarbs, total: 250, unit: 'g'),
                      NeonRing(label: 'دهون', current: _totalFat, total: 70, unit: 'g'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // ─── Calories Summary ───
            NeonCard(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_totalCalories.toInt()} / 2300 kcal',
                    style: GoogleFonts.tajawal(
                        fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.neonGreen),
                  ),
                  Text('السعرات اليومية',
                      style: GoogleFonts.tajawal(fontSize: 12, color: mutedColor)),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ─── Add Button ───
            NeonButton(
              label: 'إضافة وجبة جديدة',
              onTap: () => _showAddMealSheet(context),
            ),
            const SizedBox(height: 16),

            // ─── Meals Log ───
            const SectionTitle('سجل وجبات اليوم'),
            const SizedBox(height: 8),
            ..._meals.asMap().entries.map((e) {
              final i = e.key;
              final meal = e.value;
              return _MealCard(
                meal: meal,
                onRemove: () => setState(() => _meals.removeAt(i)),
              );
            }),

            const SizedBox(height: 16),

            // ─── Suggested ───
            const SectionTitle('قائمة الأطعمة المقترحة'),
            const SizedBox(height: 8),
            ..._suggested.map((food) => _SuggestedCard(
              food: food,
              onAdd: () => _addSuggested(food),
            )),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  void _addSuggested(_SuggestedFood food) {
    setState(() {
      _meals.add(MealEntry(
        name: food.name,
        calories: food.calories,
        protein: food.protein,
        carbs: food.carbs,
        fat: food.fat,
        grams: 100,
        time: DateTime.now(),
      ));
    });
  }

  void _showAddMealSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AddMealSheet(
        onAdd: (meal) => setState(() => _meals.add(meal)),
      ),
    );
  }
}

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
          right: BorderSide(color: AppColors.neonGreen, width: 2),
          top: BorderSide(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
          bottom: BorderSide(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
          left: BorderSide(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
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
                Text(meal.name,
                    style: GoogleFonts.tajawal(
                        fontSize: 13, fontWeight: FontWeight.w700,
                        color: isDark ? AppColors.darkText : AppColors.lightText)),
                Text(
                  '${meal.grams.toInt()}g  |  ${meal.calories.toInt()} سعرة',
                  style: GoogleFonts.tajawal(
                      fontSize: 10,
                      color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$h12:$m $ampm',
            style: GoogleFonts.tajawal(
                fontSize: 11,
                color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
          ),
        ],
      ),
    );
  }
}

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
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onAdd,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: AppColors.neonGreen,
                borderRadius: BorderRadius.circular(7),
                boxShadow: AppTheme.neonGlowList(blur: 8, opacity: 0.35),
              ),
              child: const Icon(Icons.add, color: Colors.black, size: 18),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(food.name,
                  style: GoogleFonts.tajawal(
                      fontSize: 13, fontWeight: FontWeight.w700,
                      color: isDark ? AppColors.darkText : AppColors.lightText)),
              Text('${food.calories.toInt()} سعرة حرارية',
                  style: GoogleFonts.tajawal(
                      fontSize: 10,
                      color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted)),
            ],
          ),
        ],
      ),
    );
  }
}

class _SuggestedFood {
  final String name;
  final double calories, protein, carbs, fat;
  _SuggestedFood(this.name, this.calories, this.protein, this.carbs, this.fat);
}

class _AddMealSheet extends StatefulWidget {
  final Function(MealEntry) onAdd;
  const _AddMealSheet({required this.onAdd});

  @override
  State<_AddMealSheet> createState() => _AddMealSheetState();
}

class _AddMealSheetState extends State<_AddMealSheet> {
  final _nameCtrl = TextEditingController();
  final _gramsCtrl = TextEditingController();
  final _calCtrl = TextEditingController();
  final _proteinCtrl = TextEditingController();
  final _carbsCtrl = TextEditingController();
  final _fatCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: NeonBottomSheet(
        title: 'نافذة إضافة وجبة من سلة التغذية',
        children: [
          _field('اسم الوجبة', _nameCtrl, isDark),
          _field('الكمية (g)', _gramsCtrl, isDark, isNum: true),
          _field('السعرات الحرارية', _calCtrl, isDark, isNum: true),
          _field('البروتين', _proteinCtrl, isDark, isNum: true),
          _field('الكربوهيدرات', _carbsCtrl, isDark, isNum: true),
          _field('الدهون', _fatCtrl, isDark, isNum: true),
          const SizedBox(height: 8),
          NeonButton(
            label: 'إضافة للوجبة',
            onTap: () {
              if (_nameCtrl.text.isNotEmpty) {
                widget.onAdd(MealEntry(
                  name: _nameCtrl.text,
                  calories: double.tryParse(_calCtrl.text) ?? 0,
                  protein: double.tryParse(_proteinCtrl.text) ?? 0,
                  carbs: double.tryParse(_carbsCtrl.text) ?? 0,
                  fat: double.tryParse(_fatCtrl.text) ?? 0,
                  grams: double.tryParse(_gramsCtrl.text) ?? 100,
                  time: DateTime.now(),
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
