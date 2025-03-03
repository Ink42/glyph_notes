


import 'package:flutter/material.dart';

class EditerMode extends ChangeNotifier{
  bool viewMode = false;
  
  void toggleMode(){viewMode !=viewMode; notifyListeners();}
  bool get isEditMode=> viewMode;
}