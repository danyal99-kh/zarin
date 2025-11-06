import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final List<String> items;
  final String? value;
  final String? hint;
  final bool isrequired; // <─ فقط این یکی
  final Function(String?) onChanged;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final String? errorText;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.items,
    this.value,
    this.hint,
    required this.isrequired, // <─ فقط این
    required this.onChanged,
    this.validator,
    this.prefixIcon,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: value,
        items: items.map((String item) {
          return DropdownMenuItem<String>(value: item, child: Text(item));
        }).toList(),
        onChanged: onChanged,
        validator: validator,
        borderRadius: BorderRadius.circular(20), // ← منوی گرد!
        elevation: 8,
        // ←←← منوی گرد با menuStyle (ورژنت کار میکنه!)
        dropdownColor: const Color.fromARGB(255, 50, 58, 108).withOpacity(0.9),
        style: const TextStyle(color: Colors.white),

        decoration: InputDecoration(
          errorText: errorText,
          label: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.white70, fontSize: 16),
              children: [
                TextSpan(text: label),
                if (isrequired)
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: Colors.redAccent, // ← رنگ دلخواهت رو اینجا بذار!
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
          labelStyle: const TextStyle(height: 0), // ← حتماً این خط رو اضافه کن!
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white38),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
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
            horizontal: 15,
            vertical: 10,
          ),
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: Colors.white70)
              : null,
        ),
      ),
    );
  }
}
