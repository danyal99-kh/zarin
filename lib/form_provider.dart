import 'package:flutter/material.dart';

class FormProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _dataList = [];

  List<Map<String, dynamic>> get dataList => List.unmodifiable(_dataList);

  void addData(Map<String, dynamic> data) {
    _dataList.add(data);
    notifyListeners();
  }

  void removeData(int id) {
    _dataList.removeWhere((item) => item['id'] == id);
    notifyListeners();
  }

  void updateData(int id, Map<String, dynamic> newData) {
    final index = _dataList.indexWhere((item) => item['id'] == id);
    if (index != -1) {
      _dataList[index] = newData;
      notifyListeners();
    }
  }

  void clearAll() {
    _dataList.clear();
    notifyListeners();
  }
}
