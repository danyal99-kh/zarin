// lib/widgets/custom_text_field.dart
import 'package:flutter/material.dart';
import '../models/field_model.dart'; // اگر مدل‌ها جدا هستن

class CustomTextField extends StatelessWidget {
  final TextFieldModel model;
  final String value;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? maxLength;
  final String? errorText;
  const CustomTextField({
    super.key,
    required this.model,
    required this.value,
    this.onChanged,
    this.keyboardType,
    this.maxLines = 1,
    this.maxLength,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextFormField(
        initialValue: value ?? '',
        keyboardType: keyboardType,
        maxLines: maxLines,
        maxLength: maxLength,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          label: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.white70),
              children: [
                TextSpan(text: model.label),
                if (model.isrequired)
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
          hintText: model.hint,
          hintStyle: const TextStyle(color: Colors.white38),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          counterStyle: const TextStyle(color: Colors.white54),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.3),
              width: 1,
            ),
          ),
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
          errorText: errorText,

          errorStyle: const TextStyle(color: Colors.redAccent),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 5,
          ),
          prefixIcon: _getPrefixIcon(),
          suffixIcon: maxLength != null
              ? null
              : (value.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.white70),
                        onPressed: () => onChanged?.call(''),
                      )
                    : null),
        ),

        onChanged: onChanged,
      ),
    );
  }

  Widget? _getPrefixIcon() {
    switch (model.key) {
      case 'email':
        return const Icon(Icons.email, color: Colors.white70);
      case 'name':
        return const Icon(Icons.person, color: Colors.white70);
      case 'famil':
        return const Icon(Icons.person_2, color: Colors.white70);
      case 'password':
        return const Icon(Icons.lock, color: Colors.white70);
      default:
        return null;
    }
  }
}
