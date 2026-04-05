// lib/features/scale/add_measurement_sheet.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/theme/app_theme.dart';
import 'shared/models/models.dart';
import 'shared/widgets/shared_widgets.dart';

class AddMeasurementSheet extends StatefulWidget {
  final Function(WeightEntry) onSave;

  const AddMeasurementSheet({super.key, required this.onSave});

  @override
  State<AddMeasurementSheet> createState() => _AddMeasurementSheetState();
}

class _AddMeasurementSheetState extends State<AddMeasurementSheet> {
  final _weightCtrl = TextEditingController(text: '70');
  final _fatCtrl = TextEditingController(text: '15');
  final _muscleCtrl = TextEditingController(text: '40');
  final _waistCtrl = TextEditingController(text: '85');
  final _chestCtrl = TextEditingController(text: '100');

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: NeonBottomSheet(
        title: 'نافذة إضافة قياس حيوية',
        children: [
          _inputRow('الوزن', _weightCtrl, 'كجم', isDark),
          _inputRow('نسبة الدهون', _fatCtrl, '%', isDark),
          _inputRow('نسبة العضل', _muscleCtrl, '%', isDark),
          _inputRow('محيط الخصر', _waistCtrl, 'سم', isDark),
          _inputRow('محيط الصدر', _chestCtrl, 'سم', isDark),
          const SizedBox(height: 8),
          NeonButton(
            label: 'حفظ القياس',
            onTap: () {
              final entry = WeightEntry(
                date: DateTime.now(),
                weight: double.tryParse(_weightCtrl.text) ?? 70,
                fatPercent: double.tryParse(_fatCtrl.text) ?? 15,
                musclePercent: double.tryParse(_muscleCtrl.text) ?? 40,
                waistCm: double.tryParse(_waistCtrl.text),
                chestCm: double.tryParse(_chestCtrl.text),
              );
              widget.onSave(entry);
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _inputRow(String label, TextEditingController ctrl, String suffix, bool isDark) {
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
          // Value + suffix
          Row(
            children: [
              Text(suffix,
                  style: GoogleFonts.tajawal(
                      fontSize: 12, color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted)),
              const SizedBox(width: 4),
              SizedBox(
                width: 60,
                child: TextField(
                  controller: ctrl,
                  textAlign: TextAlign.left,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  style: GoogleFonts.tajawal(
                      fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.neonGreen),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
          // Label
          Text(label,
              style: GoogleFonts.tajawal(
                  fontSize: 13,
                  color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted)),
        ],
      ),
    );
  }
}
