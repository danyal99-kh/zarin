// widgets/dynamic_form.dart
import 'package:flutter/material.dart';
import '../models/form_item_model.dart';
import 'custom_text_field.dart';
import 'custom_dropdown.dart';
import 'custom_checklist.dart';
import 'custom_radio.dart';

class DynamicForm extends StatelessWidget {
  final List<FormItemModel> fields;
  final Function(int id, dynamic value) onChanged;
  final Map<String, String> errors;

  const DynamicForm({
    Key? key,
    required this.fields,
    required this.onChanged,
    this.errors = const {},
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: fields.map((field) {
        final error = errors['${field.id}'];

        switch (field.type) {
          case FieldType.text:
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: CustomTextField(
                model: field,
                onChanged: (v) => onChanged(field.id, v),
                errorText: error,
              ),
            );

          case FieldType.dropdown:
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: CustomDropdown(
                model: field,
                onChanged: (v) => onChanged(field.id, v),
                errorText: error,
              ),
            );

          case FieldType.checkbox:
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: CustomChecklist(
                model: field,
                onChanged: (v) => onChanged(field.id, v),
                errorText: error,
              ),
            );

          case FieldType.radio:
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: CustomRadio(
                model: field,
                onChanged: (v) => onChanged(field.id, v),
                errorText: error,
              ),
            );
        }
      }).toList(),
    );
  }
}
