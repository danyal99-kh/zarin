// lib/widgets/custom_checklist.dart
import 'package:flutter/material.dart';
import '../models/form_item_model.dart';

class CustomChecklist extends StatelessWidget {
  final FormItemModel model;
  final Function(bool) onChanged;
  final String? errorText;

  const CustomChecklist({
    super.key,
    required this.model,
    required this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final bool isChecked = model.value == true;

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

            Row(
              children: [
                Transform.scale(
                  scale: 1.3,
                  child: Checkbox(
                    value: isChecked,
                    onChanged: (val) => onChanged(val ?? false),
                    activeColor: Colors.white,
                    checkColor: Colors.black87,
                    side: BorderSide(
                      color: errorText != null && model.required
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
                        TextSpan(text: model.label),
                        if (model.required)
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
          ],
        ),
      ),
    );
  }
}
