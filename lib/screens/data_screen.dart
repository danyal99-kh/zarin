import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zarin/form_provider.dart';
import '../widgets/glass_morphism_card.dart';
import '../screens/home_screen.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A1A2E),
            Color(0xFF16213E),
            Color(0xFF0F3460),
            Color(0xFF1E1E3F),
          ],
          stops: [0.0, 0.4, 0.7, 1.0],
        ),
      ),
      child: Consumer<FormProvider>(
        builder: (context, provider, child) {
          final dataList = provider.dataList;

          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Text('داده‌های ثبت شده'),
              backgroundColor: Colors.black.withOpacity(0.3),
              elevation: 0,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            body: dataList.isEmpty
                ? const Center(
                    child: Text(
                      'هیچ داده‌ای ثبت نشده',
                      style: TextStyle(color: Colors.white70, fontSize: 18),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: dataList.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final data = dataList[index];
                      return GlassMorphismCard(
                        child: ListTile(
                          title: Text(
                            data['name'] ?? 'بدون نام',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'موبایل: ${data['mobile']}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.cyanAccent,
                                ),
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
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
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
      ),
    );
  }
}
