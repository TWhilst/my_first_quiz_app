import 'package:flutter/material.dart';

class HomeViewModel with ChangeNotifier{
  bool _isTapped = false;
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  bool _isChecked3 = false;
  bool _isChecked4 = false;


  bool get isTapped => _isTapped;
  bool get isChecked1 => _isChecked1;
  bool get isChecked2 => _isChecked2;
  bool get isChecked3 => _isChecked3;
  bool get isChecked4 => _isChecked4;

  set setTapped(bool isTapped) {
    _isTapped = isTapped;
    notifyListeners();
  }

  set setChecked1(bool isChecked1) {
    _isChecked1 = isChecked1;
    notifyListeners();
  }

  set setChecked2(bool isChecked2) {
    _isChecked2 = isChecked2;
    notifyListeners();
  }

  set setChecked3(bool isChecked3) {
    _isChecked3 = isChecked3;
    notifyListeners();
  }

  set setChecked4(bool isChecked4) {
    _isChecked4 = isChecked4;
    notifyListeners();
  }


}