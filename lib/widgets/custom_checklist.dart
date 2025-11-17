// lib/widgets/custom_checkbox.dart
import 'package:flutter/material.dart';
import '../models/form_item_model.dart';

class CustomCheckbox extends StatelessWidget {
  final FormItemModel model;
  final Function(dynamic) onChanged;
  final String? errorText;

  const CustomCheckbox({
    super.key,
    required this.model,
    required this.onChanged,
    this.errorText,
  });
  @override
  Widget build(BuildContext context) {
    final bool isMulti = model.options != null && model.options!.isNotEmpty;

    List<String> selectedValues = [];
    if (isMulti) {
      if (model.value is List<dynamic>) {
        selectedValues = model.value.cast<String>();
      } else if (model.value is String && model.value.toString().isNotEmpty) {
        selectedValues = [model.value.toString()];
      }
    }

    const double checkboxScale = 1.35;

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
                  style: const TextStyle(color: Colors.redAccent, fontSize: 14),
                ),
              ),

            // عنوان
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
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
            const SizedBox(height: 16),

            if (!isMulti)
              Row(
                children: [
                  Transform.scale(
                    scale: checkboxScale,
                    child: Checkbox(
                      value: model.value == true || model.value == 'true',
                      onChanged: (val) => onChanged(val ?? false),
                      activeColor: const Color.fromARGB(255, 189, 189, 189),
                      checkColor: const Color.fromARGB(255, 0, 0, 0),
                      side: const BorderSide(color: Colors.white70, width: 2.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'فعال / غیرفعال',
                      style: TextStyle(color: Colors.white70, fontSize: 15),
                    ),
                  ),
                ],
              )
            else
              ...model.options!.map((option) {
                final bool isChecked = selectedValues.contains(option);

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      if (isChecked) {
                        selectedValues.remove(option);
                      } else {
                        selectedValues.add(option);
                      }
                      onChanged(selectedValues.toList());
                    },
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: checkboxScale,
                          child: Checkbox(
                            value: isChecked,
                            onChanged: (val) {
                              if (val == true) {
                                if (!selectedValues.contains(option))
                                  selectedValues.add(option);
                              } else {
                                selectedValues.remove(option);
                              }
                              onChanged(selectedValues.toList());
                            },
                            activeColor: const Color.fromARGB(
                              255,
                              189,
                              189,
                              189,
                            ),
                            checkColor: const Color.fromARGB(255, 0, 0, 0),
                            side: const BorderSide(
                              color: Colors.white70,
                              width: 2.2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            option,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
          ],
        ),
      ),
    );
  }
}
