// lib/widgets/custom_checklist.dart
import 'package:flutter/material.dart';
import 'package:zarin/models/field_model.dart';

class CustomChecklist extends StatelessWidget {
  final List<ChecklistItem> items;
  final Map<String, bool> values;
  final Function(String, bool)? onChanged;
  final String? errorText;
  final String? title;

  const CustomChecklist({
    super.key,
    required this.items,
    required this.values,
    this.onChanged,
    this.errorText,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: errorText != null
                ? Colors.redAccent
                : Colors.white.withOpacity(0.3),
            width: errorText != null ? 2.0 : 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // عنوان
            if (title != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  title!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            // خطای اعتبارسنجی
            if (errorText != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  errorText!,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 120, 120),
                    fontSize: 14,
                  ),
                ),
              ),

            // آیتم‌های چک‌لیست
            ...items.map((item) {
              final bool isChecked = values[item.key] ?? false;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 1),
                child: Row(
                  children: [
                    Transform.scale(
                      scale: 1.3,
                      child: Checkbox(
                        value: isChecked,
                        onChanged: (val) {
                          onChanged?.call(item.key, val ?? false);
                        },
                        activeColor: Colors.white,
                        checkColor: Colors.black87,
                        side: BorderSide(
                          color: errorText != null && item.isRequired
                              ? Colors.redAccent
                              : Colors.white70,
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        overlayColor: WidgetStateProperty.all(
                          Colors.white.withOpacity(0.3),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                            height: 1.4,
                          ),
                          children: [
                            TextSpan(text: item.label),
                            if (item.isRequired)
                              const TextSpan(
                                text: ' *',
                                style: TextStyle(color: Colors.redAccent),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
