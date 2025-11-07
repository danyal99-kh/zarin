import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zarin/form_provider.dart';
import 'package:zarin/widgets/custom_checklist.dart';
import 'package:zarin/widgets/custom_dropdown.dart';
import 'package:zarin/widgets/glass_morphism_card.dart';
import 'package:zarin/screens/data_screen.dart';
import 'package:zarin/widgets/custom_text_field.dart';
import 'package:zarin/models/field_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  String _name = '';
  String _email = '';
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _name);
    _emailController = TextEditingController(text: _email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  String? _selectedProvince;
  String? _selectedCustomerType;

  Map<String, bool> checklistValues = {
    'terms': false,
    'newsletter': false,
    'privacy': false,
  };

  Map<String, bool> checklistValues2 = {'offers': false, 'notif': false};

  String? _nameError;
  String? _emailError;
  String? _provinceError;
  String? _customerTypeError;
  String? _termsError;

  @override
  Widget build(BuildContext context) {
    final double maxCardWidth = 800.0;

    final TextFieldModel nameFieldModel = TextFieldModel(
      label: 'نام شما',
      key: 'name',
      isrequired: true,
      hint: 'نام خود را وارد کنید',
      keyboardType: TextInputType.name,
    );
    final TextFieldModel emailFieldModel = TextFieldModel(
      label: "ایمیل",
      key: 'email',
      isrequired: true,
      hint: 'ایمیل خود را وارد کنید',
      keyboardType: TextInputType.emailAddress,
    );

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
                      const Text(
                        'فرم داینامیک',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // فیلدهای متنی
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              model: nameFieldModel,
                              controller: _nameController,
                              onChanged: (v) => setState(() => _name = v),
                              errorText: _nameError,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: CustomTextField(
                              model: emailFieldModel,
                              controller: _emailController,
                              onChanged: (v) => setState(() => _email = v),
                              errorText: _emailError,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // دراپ‌دان‌ها
                      CustomDropdown(
                        label: 'استان',
                        isrequired: true,
                        items: const [
                          'تهران',
                          'اصفهان',
                          'شیراز',
                          'مشهد',
                          'کردستان',
                        ],
                        value: _selectedProvince,
                        hint: 'استان خود را انتخاب کنید',
                        prefixIcon: Icons.location_on,
                        onChanged: (v) => setState(() => _selectedProvince = v),
                        errorText: _provinceError,
                      ),
                      const SizedBox(height: 12),
                      CustomDropdown(
                        label: 'نوع مشتری',
                        isrequired: true,
                        items: const ['عمده فروش', 'خرده فروش', 'شرکت', 'فرد'],
                        value: _selectedCustomerType,
                        hint: 'نوع مشتری را انتخاب کنید',
                        prefixIcon: Icons.person_outline,
                        onChanged: (v) =>
                            setState(() => _selectedCustomerType = v),
                        errorText: _customerTypeError,
                      ),
                      const SizedBox(height: 16),

                      // چک‌لیست‌ها
                      CustomChecklist(
                        title: 'شرایط و قوانین',
                        items: [
                          ChecklistItem(
                            key: 'terms',
                            label: 'قوانین را می‌پذیرم',
                            isRequired: true,
                          ),
                          ChecklistItem(
                            key: 'newsletter',
                            label: 'دریافت خبرنامه',
                            hint: 'اخبار هفتگی',
                          ),
                          ChecklistItem(
                            key: 'privacy',
                            label: 'حریم خصوصی را خواندم',
                          ),
                        ],
                        values: checklistValues,
                        onChanged: (k, v) =>
                            setState(() => checklistValues[k] = v),
                        errorText: _termsError,
                      ),
                      const SizedBox(height: 12),
                      CustomChecklist(
                        title: 'اطلاع‌رسانی',
                        items: [
                          ChecklistItem(key: 'offers', label: 'تخفیفات'),
                          ChecklistItem(key: 'notif', label: 'اطلاعیه‌ها'),
                        ],
                        values: checklistValues2,
                        onChanged: (k, v) =>
                            setState(() => checklistValues2[k] = v),
                      ),
                      const SizedBox(height: 24),

                      // دکمه‌ها
                      Row(
                        children: [
                          Expanded(
                            child: _buildButton(
                              context,
                              icon: Icons.check_circle,
                              label: 'ساخت',
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

  void _submitForm() {
    // 1. اعتبارسنجی
    setState(() {
      _nameError = _name.trim().isEmpty ? 'نام الزامی است' : null;
      _emailError = _email.trim().isEmpty ? 'ایمیل الزامی است' : null;
      _provinceError = _selectedProvince == null
          ? 'استان را انتخاب کنید'
          : null;
      _customerTypeError = _selectedCustomerType == null
          ? 'نوع مشتری را انتخاب کنید'
          : null;
      _termsError = !checklistValues['terms']!
          ? 'پذیرش قوانین الزامی است'
          : null;
    });

    // 2. اگر خطا بود، متوقف شو
    if (_nameError != null ||
        _emailError != null ||
        _provinceError != null ||
        _customerTypeError != null ||
        _termsError != null) {
      return;
    }

    // 3. ساخت داده
    final formData = {
      'id': DateTime.now().millisecondsSinceEpoch,
      'name': _name.trim(),
      'email': _email.trim(),
      'province': _selectedProvince!,
      'customerType': _selectedCustomerType!,
      'newsletter': checklistValues['newsletter']!,
      'privacy': checklistValues['privacy']!,
      'offers': checklistValues2['offers']!,
      'notif': checklistValues2['notif']!,
    };

    // 4. اضافه کردن به Provider
    Provider.of<FormProvider>(context, listen: false).addData(formData);

    // 5. نمایش اسنک‌بار
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('داده با موفقیت ثبت شد'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );

    // 6. ریست فرم
    _resetForm();
  }

  void _resetForm() {
    setState(() {
      _name = '';
      _email = '';
      _selectedProvince = null;
      _selectedCustomerType = null;
      checklistValues.updateAll((k, v) => false);
      checklistValues2.updateAll((k, v) => false);
      _nameError = _emailError = _provinceError = _customerTypeError =
          _termsError = null;
      _nameController.clear();
      _emailController.clear();
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
}
