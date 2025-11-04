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

  const CustomTextField({
    super.key,
    required this.model,
    required this.value,
    this.onChanged,
    this.keyboardType,
    this.maxLines = 1,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: value,
        keyboardType: keyboardType,
        maxLines: maxLines,
        maxLength: maxLength,
        style: const TextStyle(color: Colors.white), // متن سفید برای گلس
        decoration: InputDecoration(
          labelText: model.label + (model.isrequired ? ' *' : ''),
          labelStyle: const TextStyle(color: Colors.white70),
          hintText: model.hint,
          hintStyle: const TextStyle(color: Colors.white38),
          filled: true,
          fillColor: Colors.white.withOpacity(
            0.2,
          ), // زمینه نیمه‌شفاف برای شیشه‌ای‌تر
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
          errorStyle: const TextStyle(color: Colors.redAccent),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
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
        validator: (val) {
          if (model.isrequired && (val == null || val.isEmpty)) {
            return 'فیلد اجباری است';
          }
          // ولیدیشن اضافی (مثلاً ایمیل)
          if (model.key == 'email' && val != null && !val.contains('@')) {
            return 'ایمیل معتبر نیست';
          }
          return null;
        },
        onChanged: onChanged,
      ),
    );
  }

  Widget? _getPrefixIcon() {
    // آیکون بر اساس key فیلد (قابل گسترش)
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
