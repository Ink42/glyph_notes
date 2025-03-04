


import 'package:flutter/material.dart';

class EditerMode extends ChangeNotifier {
  bool _isEditMode = false;
  
  bool get isEditMode => _isEditMode;
  
  void toggleMode() {
    _isEditMode = !_isEditMode;
    notifyListeners();
  }
}