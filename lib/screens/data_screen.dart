// data_screen.dart
import 'package:flutter/material.dart';

class DataScreen extends StatefulWidget {
  final Map<String, dynamic>? newData;
  const DataScreen({super.key, this.newData});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  List<Map<String, dynamic>> dataList = [];
  @override
  void initState() {
    super.initState();
    if (widget.newData != null && widget.newData is Map<String, dynamic>) {
      dataList.add(Map<String, dynamic>.from(widget.newData!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('داده‌های ثبت شده'),
        backgroundColor: Colors.deepPurple,
      ),
      body: dataList.isEmpty
          ? const Center(child: Text('هنوز داده‌ای ثبت نشده'))
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('نام')),
                  DataColumn(label: Text('ایمیل')),
                  DataColumn(label: Text('استان')),
                  DataColumn(label: Text('نوع مشتری')),
                  DataColumn(label: Text('عملیات')),
                ],
                rows: dataList.map((data) {
                  return DataRow(
                    cells: [
                      DataCell(Text(data['name']?.toString() ?? '')),
                      DataCell(Text(data['email']?.toString() ?? '')),
                      DataCell(Text(data['province']?.toString() ?? '')),
                      DataCell(Text(data['customerType']?.toString() ?? '')),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _editItem(data),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteItem(data['id']),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
    );
  }

  void _editItem(Map<String, dynamic> item) {
    // اینجا می‌تونی یه دیالوگ ویرایش باز کنی
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('ویرایش'),
        content: const Text('در نسخه بعدی اضافه می‌شود'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('بستن'),
          ),
        ],
      ),
    );
  }

  void _deleteItem(int id) {
    setState(() {
      dataList.removeWhere((item) => item['id'] == id);
    });
  }
}
