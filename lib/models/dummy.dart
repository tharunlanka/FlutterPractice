import 'package:flutter/material.dart';
class DummyDataClass extends ChangeNotifier{
  int _x=0;
  int get X=> _x;

  void incrementX(){
    _x++;
    notifyListeners();
}
}