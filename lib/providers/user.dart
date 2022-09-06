import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  String name = '';
  bool authenticated = false;

  login() {
    authenticated = true;
    name = 'Arun';
    notifyListeners();
  }
}
