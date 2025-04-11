import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isdark = false;
  bool _overrideSystemTheme = true;

  toggleTheme() {
    if (_overrideSystemTheme) {
      _isdark = !_isdark;
      notifyListeners();
    }
  }

  toggleCanOverrideTheme() {
    _overrideSystemTheme = !_overrideSystemTheme;
    notifyListeners();
  }

  bool fetchTheme() => _isdark;
  bool fetchCanOverrideTheme() => _overrideSystemTheme;
}
