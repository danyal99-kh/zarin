import 'package:flutter/material.dart';
import 'package:zarin/widgets/custom_dropdown.dart';
import '../widgets/custom_text_field.dart';

abstract class FormFieldModel {
  final String label;
  final String key;
  final bool isrequired;
  final String? hint;

  FormFieldModel({
    required this.label,
    required this.key,
    this.isrequired = false,
    this.hint,
  });

  Widget buildWidget({
    required dynamic value,
    required Function(dynamic) onChanged,
  });

  dynamic getDefaultValue();
}

//تکست فیلد
class TextFieldModel extends FormFieldModel {
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? maxLength;

  TextFieldModel({
    required super.label,
    required super.key,
    super.isrequired,
    super.hint,
    this.keyboardType,
    this.maxLines,
    this.maxLength,
  });

  @override
  Widget buildWidget({
    required dynamic value,
    required Function(dynamic) onChanged,
  }) {
    final String textValue = (value is String)
        ? value
        : (value?.toString() ?? '');

    return CustomTextField(
      model: this,
      value: textValue,
      onChanged: (String newValue) => onChanged(newValue),
      keyboardType: keyboardType,
      maxLines: maxLines,
      maxLength: maxLength,
    );
  }

  @override
  dynamic getDefaultValue() => '';
}

//دراپ داون
class DropdownFieldModel extends FormFieldModel {
  final List<String> items;
  final IconData? prefixIcon;

  DropdownFieldModel({
    required super.label,
    required super.key,
    super.isrequired,
    super.hint,
    required this.items,
    this.prefixIcon,
  }) : assert(items.isNotEmpty, 'items cannot be empty');

  @override
  Widget buildWidget({
    required dynamic value,
    required Function(dynamic) onChanged,
  }) {
    final String? selectedValue = value is String ? value : null;

    return CustomDropdown(
      label: label,
      items: items,
      value: selectedValue,
      hint: hint,
      isrequired: isrequired,
      prefixIcon: prefixIcon,
      onChanged: (String? newValue) => onChanged(newValue),
      validator: (val) {
        if (isrequired && (val == null || val.isEmpty)) {
          return 'این فیلد اجباری است';
        }
        return null;
      },
    );
  }

  @override
  dynamic getDefaultValue() => null;
}

//چک لیست
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
