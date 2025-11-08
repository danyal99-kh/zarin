// lib/widgets/custom_radio.dart
import 'package:flutter/material.dart';
import '../models/form_item_model.dart';

class CustomRadio extends StatelessWidget {
  final FormItemModel model;
  final Function(String?) onChanged;
  final String? errorText;

  const CustomRadio({
    super.key,
    required this.model,
    required this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (errorText != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                errorText!,
                style: const TextStyle(color: Colors.redAccent),
              ),
            ),
          ...model.options!.map((option) {
            return RadioListTile<String>(
              value: option,
              groupValue: model.value,
              onChanged: onChanged,
              title: Text(option, style: const TextStyle(color: Colors.white)),
              activeColor: Colors.white,
              tileColor: Colors.white.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            );
          }),
        ],
      ),
    );
  }
}
