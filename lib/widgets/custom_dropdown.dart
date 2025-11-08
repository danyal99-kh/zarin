// lib/widgets/custom_dropdown.dart
import 'package:flutter/material.dart';
import '../models/form_item_model.dart';

class CustomDropdown extends StatelessWidget {
  final FormItemModel model;
  final Function(String?) onChanged;
  final String? errorText;

  const CustomDropdown({
    super.key,
    required this.model,
    required this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    String? selectedValue;
    if (model.value != null && model.value.toString().isNotEmpty) {
      selectedValue = model.value.toString();
    }

    // اگر مقدار در options نبود، null کن
    if (selectedValue != null && !model.options!.contains(selectedValue)) {
      selectedValue = null;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        hint: model.hint != null
            ? Text(model.hint!, style: const TextStyle(color: Colors.white38))
            : const Text('انتخاب کنید'),
        items: model.options!.map((String item) {
          return DropdownMenuItem<String>(value: item, child: Text(item));
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            // مهم: مقدار رو به model.value بده
            model.value = newValue;

            // سپس به HomeScreen اطلاع بده
            onChanged(newValue);
          }
        },
        borderRadius: BorderRadius.circular(20),
        elevation: 8,
        dropdownColor: const Color.fromARGB(255, 50, 58, 108).withOpacity(0.9),
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          errorText: errorText,
          label: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.white70, fontSize: 16),
              children: [
                TextSpan(text: model.label),
                if (model.required)
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
          labelStyle: const TextStyle(height: 0),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.3),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.white, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.redAccent, width: 2),
          ),
          errorStyle: const TextStyle(color: Colors.redAccent),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          prefixIcon: model.prefixIcon != null
              ? Icon(model.prefixIcon, color: Colors.white70)
              : null,
        ),
        validator: model.required
            ? (value) {
                if (value == null || value.isEmpty) {
                  return '${model.label} الزامی است';
                }
                return null;
              }
            : null,
      ),
    );
  }
}
