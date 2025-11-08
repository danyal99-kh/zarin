// lib/screens/data_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zarin/form_provider.dart';
import '../widgets/glass_morphism_card.dart';
import '../screens/home_screen.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FormProvider>(
      builder: (context, provider, child) {
        final dataList = provider.dataList;

        return Scaffold(
          appBar: AppBar(title: const Text('داده‌های ثبت شده')),
          body: dataList.isEmpty
              ? const Center(child: Text('هیچ داده‌ای ثبت نشده'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    final data = dataList[index];
                    return GlassMorphismCard(
                      child: ListTile(
                        title: Text(
                          data['name'] ?? 'بدون نام',
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          'موبایل: ${data['mobile']}',
                          style: const TextStyle(color: Colors.white70),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        HomeScreen(editingItem: data),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                provider.removeData(data['id']);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
