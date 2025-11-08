import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zarin/form_provider.dart';
import 'package:zarin/models/form_item_model.dart';
import 'package:zarin/widgets/glass_morphism_card.dart';
import 'package:zarin/screens/data_screen.dart';
import 'package:zarin/widgets/dynamic_form.dart';

// ====================== لیست فرم نمونه  ======================

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
    keyboardType: TextInputType.number,
    inputFormatters: [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(11),
    ],
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
    value: '',
  ),
  FormItemModel(
    id: 4,
    key: 'isActive',
    label: 'وضعیت فعال بودن',
    type: FieldType.checkbox,
    value: "",
  ),
  FormItemModel(
    id: 5,
    key: 'gender',
    label: 'جنسیت',
    type: FieldType.radio,
    options: ['مرد', 'زن'],
    value: 'مرد',
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
  final List<TextEditingController> _textControllers = [];
  @override
  void initState() {
    super.initState();
    _initializeForm(); // اینجا فراخوانی میشه

    if (widget.editingItem != null) {
      isEditMode = true;
      editingId = widget.editingItem!['id'];
      _loadEditData();
    }
  }

  void _initializeForm() {
    // پاک کردن کنترلرهای قبلی (برای reset)
    for (var c in _textControllers) {
      c.dispose();
    }
    _textControllers.clear();

    formFields = customerForm.map((f) {
      final controller = TextEditingController(text: f.value);
      if (f.type == FieldType.text) {
        _textControllers.add(controller);
      }
      return f.copyWith(controller: controller);
    }).toList();
  }

  void _loadEditData() {
    final data = widget.editingItem!;
    for (var field in formFields) {
      if (data.containsKey(field.key)) {
        final value = data[field.key].toString();
        field.controller?.text = value; // مقدار رو به کنترلر بده
        field.value = value; // اختیاری: برای اعتبارسنجی
      }
    }
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
      if (field.type == FieldType.text && field.controller != null) {
        field.value = field.controller!.text.trim();
      }

      if (field.required && field.value.toString().isEmpty) {
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
      _initializeForm(); // کنترلرها دوباره ساخته میشن
      errors.clear();
    });
  }

  @override
  void dispose() {
    for (var c in _textControllers) {
      c.dispose();
    }
    super.dispose();
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
              Color(0xFF1A1A2E), // آبی تیره
              Color(0xFF16213E), // آبی خیلی تیره
              Color(0xFF0F3460), // آبی عمیق
              Color(0xFF1E1E3F), // بنفش تیر
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
