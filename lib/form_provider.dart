// lib/providers/form_provider.dart
import 'package:flutter/foundation.dart';

class FormProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _dataList = [];

  List<Map<String, dynamic>> get dataList => List.unmodifiable(_dataList);

  void addData(Map<String, dynamic> data) {
    _dataList.add(data);
    notifyListeners();
  }

  void updateData(int id, Map<String, dynamic> data) {
    final index = _dataList.indexWhere((e) => e['id'] == id);
    if (index != -1) {
      _dataList[index] = data;
      notifyListeners();
    }
  }

  void removeData(int id) {
    _dataList.removeWhere((e) => e['id'] == id);
    notifyListeners();
  }
}
