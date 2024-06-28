import 'package:flutter/material.dart';

class Finisher extends ChangeNotifier{
  bool isfinished = false;
  String results = "";

  void finish(String outcome){
    results = outcome;
    isfinished = true;
    notifyListeners();
  }
}