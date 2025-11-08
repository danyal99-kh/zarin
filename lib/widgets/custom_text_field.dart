// lib/widgets/custom_text_field.dart
import 'package:flutter/material.dart';
import '../models/form_item_model.dart';

class CustomTextField extends StatelessWidget {
  final FormItemModel model;
  final String? errorText;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.model,
    this.errorText,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController effectiveController =
        controller ?? model.controller!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: effectiveController,
        builder: (context, value, child) {
          return TextFormField(
            controller: effectiveController,
            keyboardType: model.keyboardType,
            inputFormatters: model.inputFormatters,
            maxLines: model.type == FieldType.text ? 1 : null,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              label: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.white70),
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
              hintText: model.hint,
              hintStyle: const TextStyle(color: Colors.white38),
              filled: true,
              fillColor: Colors.white.withOpacity(0.2),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
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
              suffixIcon: value.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: Colors.white70),
                      onPressed: () {
                        effectiveController.clear();
                      },
                    )
                  : null,
            ),
            // onChanged: حذف شد!
          );
        },
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
