import 'package:flutter/material.dart';

class CekProvider with ChangeNotifier {
  String _selectedCategory = '';

  String get selectedCategory => _selectedCategory;

  void setCategory(String cekout) {
    _selectedCategory = cekout;
    notifyListeners();
  }
}
