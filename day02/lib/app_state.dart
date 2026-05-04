import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  int selectedCategoryId = 0;
  void updateCategoryId(int selectedId) {
    selectedCategoryId = selectedId;
    notifyListeners();
  }
}
