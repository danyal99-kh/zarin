import 'package:flutter/material.dart';
import 'package:zarin/widgets/custom_dropdown.dart';
import 'package:zarin/widgets/glass_morphism_card.dart';
import 'package:zarin/screens/form_screen.dart';
import 'package:zarin/screens/data_screen.dart';
import 'package:zarin/widgets/custom_text_field.dart';
import 'package:zarin/models/field_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _textValue = '';
  String? _selectedProvince;

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
    final TextFieldModel familFieldModel = TextFieldModel(
      label: 'نام خانوادگی شما',
      key: 'famil',
      isrequired: true,
      hint: 'نام خانوادگی خود را وارد کنید',
      keyboardType: TextInputType.name,
    );

    return Scaffold(
      body: Container(
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'فرم داینامیک طرف حساب',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 237, 237, 237),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: CustomTextField(
                        model: nameFieldModel,
                        value: _textValue,
                        onChanged: (newValue) {
                          setState(() {
                            _textValue = newValue;
                          });
                        },
                        keyboardType: nameFieldModel.keyboardType,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: CustomTextField(
                        model: familFieldModel,
                        value: _textValue,
                        onChanged: (newValue) {
                          setState(() {
                            _textValue = newValue;
                          });
                        },
                        keyboardType: familFieldModel.keyboardType,
                      ),
                    ),
                    const SizedBox(height: 10),

                    CustomDropdown(
                      label: 'استان',
                      isRequired: true,
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
                      onChanged: (newValue) {
                        setState(() {
                          _selectedProvince = newValue;
                        });
                      },
                      isrequired: false,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: _buildButton(
                            context,
                            icon: Icons.edit_note,
                            label: 'ساخت فرم',
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const FormScreen(),
                              ),
                            ),
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
    );
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
      label: Text(label, style: const TextStyle(fontSize: 18)),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        backgroundColor: Colors.white.withOpacity(0.2),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
