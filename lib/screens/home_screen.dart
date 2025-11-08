import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zarin/form_provider.dart';
import 'package:zarin/models/form_item_model.dart';
import 'package:zarin/widgets/glass_morphism_card.dart';
import 'package:zarin/screens/data_screen.dart';
import 'package:zarin/widgets/dynamic_form.dart';

// ====================== لیست فرم نمونه (مثل PDF) ======================

final List<FormItemModel> customerForm = [
  FormItemModel(
    id: 1,
    key: 'name',
    label: 'نام طرف حساب',
    type: FieldType.text,
    required: true,
    hint: 'نام خود را وارد کنید',
    keyboardType: TextInputType.name,
    value: '',
  ),
  FormItemModel(
    id: 2,
    key: 'mobile',
    label: 'شماره موبایل',
    type: FieldType.text,
    required: true,
    hint: 'شماره موبایل خود را وارد کنید',
    keyboardType: TextInputType.phone,
    value: '',
  ),
  FormItemModel(
    id: 3,
    key: 'accountType',
    label: 'نوع طرف حساب',
    type: FieldType.dropdown,
    required: true,
    options: ['حقیقی', 'حقوقی'],
    hint: 'نوع طرف حساب را انتخاب کنید',
    value: 'حقیقی',
  ),
  FormItemModel(
    id: 4,
    key: 'isActive',
    label: 'وضعیت فعال بودن',
    type: FieldType.checkbox,
    value: true,
  ),
  FormItemModel(
    id: 5,
    key: 'gender',
    label: 'جنسیت',
    type: FieldType.radio,
    options: ['مرد', 'زن'],
    value: 'مرد',
  ),
  FormItemModel(
    id: 6,
    label: "سلام",
    type: FieldType.checkbox,
    key: 'isActive',
  ),
  FormItemModel(
    id: 7,
    label: "fef",
    type: FieldType.dropdown,
    key: "province",
    options: ["تهران", "اصفهان", "شیراز"],
  ),
  FormItemModel(
    id: 8,
    label: "fef",
    type: FieldType.dropdown,
    key: "province",
    options: ["تهران", "اصفهان", "شیراز"],
  ),
];
// =================================================================

class HomeScreen extends StatefulWidget {
  final Map<String, dynamic>? editingItem;
  const HomeScreen({super.key, this.editingItem});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<FormItemModel> formFields;
  Map<String, String> errors = {};
  bool isEditMode = false;
  int? editingId;

  @override
  void initState() {
    super.initState();
    formFields = customerForm.map((f) => f.copyWith()).toList();

    if (widget.editingItem != null) {
      isEditMode = true;
      editingId = widget.editingItem!['id'];
      _loadEditData();
    }
  }

  void _loadEditData() {
    final data = widget.editingItem!;
    for (var field in formFields) {
      if (data.containsKey(field.key)) {
        field.value = data[field.key];
      }
    }
    setState(() {});
  }

  void _onFieldChanged(int id, dynamic value) {
    setState(() {
      final field = formFields.firstWhere((f) => f.id == id);
      field.value = value;
    });
  }

  void _submitForm() {
    errors.clear();
    for (var field in formFields) {
      if (field.required &&
          (field.value == null || field.value.toString().isEmpty)) {
        errors['${field.id}'] = '${field.label} الزامی است';
      }
    }

    if (errors.isNotEmpty) {
      setState(() {});
      return;
    }

    final data = <String, dynamic>{
      'id': isEditMode ? editingId : DateTime.now().millisecondsSinceEpoch,
      for (var field in formFields) field.key: field.value,
    };

    final provider = Provider.of<FormProvider>(context, listen: false);
    if (isEditMode) {
      provider.updateData(editingId!, data);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ویرایش شد'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      provider.addData(data);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('داده با موفقیت ثبت شد'),
          backgroundColor: Colors.green,
        ),
      );
    }

    _resetForm();
  }

  void _resetForm() {
    setState(() {
      formFields = customerForm.map((f) => f.copyWith()).toList();
      errors.clear();
    });
  }

  Widget _buildButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label, style: const TextStyle(fontSize: 16)),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        backgroundColor: Colors.white.withOpacity(0.2),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double maxCardWidth = 800.0;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 59, 112, 210),
              Color(0xFF2A5298),
              Color(0xFF4A00E0),
              Color.fromARGB(255, 113, 10, 202),
            ],
            stops: [0.0, 0.4, 0.7, 1.0],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 24.0,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxCardWidth),
              child: GlassMorphismCard(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        isEditMode ? 'ویرایش طرف حساب' : 'فرم داینامیک',
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // فرم داینامیک
                      DynamicForm(
                        fields: formFields,
                        onChanged: _onFieldChanged,
                        errors: errors,
                      ),

                      const SizedBox(height: 24),

                      // دکمه‌ها
                      Row(
                        children: [
                          Expanded(
                            child: _buildButton(
                              context,
                              icon: Icons.check_circle,
                              label: isEditMode ? 'ویرایش' : 'ساخت',
                              onPressed: _submitForm,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildButton(
                              context,
                              icon: Icons.table_chart,
                              label: 'داده‌ها',
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const DataScreen(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // دکمه‌های ویرایش/حذف/لغو
                      if (isEditMode) ...[
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Provider.of<FormProvider>(
                                  context,
                                  listen: false,
                                ).removeData(editingId!);
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('حذف شد'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: const Text('حذف'),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('لغو'),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
