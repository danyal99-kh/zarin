// models/form_item_model.dart
import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/custom_checklist.dart';
import '../widgets/custom_radio.dart';

enum FieldType { text, dropdown, checkbox, radio }

class FormItemModel {
  final int id;
  final String label;
  final FieldType type;
  final bool required;
  final String? hint;
  final List<String>? options;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final List<ChecklistItem>? checklistItems; // فقط برای checkbox
  dynamic value;
  final String key;
  FormItemModel({
    required this.id,
    required this.label,
    required this.type,
    this.required = false,
    this.hint,
    this.options,
    this.keyboardType,
    this.prefixIcon,
    this.checklistItems,
    required this.key,
    this.value,
  });

  // کپی با مقدار جدید
  FormItemModel copyWith({dynamic value}) {
    return FormItemModel(
      id: id,
      label: label,
      type: type,
      required: required,
      hint: hint,
      options: options,
      keyboardType: keyboardType,
      prefixIcon: prefixIcon,
      checklistItems: checklistItems,
      value: value ?? this.value,
      key: key,
    );
  }

  // ساخت ویجت داینامیک
  Widget buildWidget({
    required Function(dynamic) onChanged,
    String? errorText,
  }) {
    switch (type) {
      case FieldType.text:
        return CustomTextField(
          model: this,
          onChanged: onChanged,
          errorText: errorText,
        );

      case FieldType.dropdown:
        return CustomDropdown(
          model: this,
          onChanged: onChanged,
          errorText: errorText,
        );

      case FieldType.checkbox:
        return CustomChecklist(
          model: this,
          onChanged: onChanged,
          errorText: errorText,
        );

      case FieldType.radio:
        return CustomRadio(
          model: this,
          onChanged: onChanged,
          errorText: errorText,
        );
    }
  }

  dynamic getDefaultValue() {
    switch (type) {
      case FieldType.text:
        return '';
      case FieldType.dropdown:
      case FieldType.radio:
        return null;
      case FieldType.checkbox:
        return false;
    }
  }
}

// برای چک‌لیست
class ChecklistItem {
  final String key;
  final String label;
  final bool isRequired;
  final String? hint;

  ChecklistItem({
    required this.key,
    required this.label,
    this.isRequired = false,
    this.hint,
  });
}
