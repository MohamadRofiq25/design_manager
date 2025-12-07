import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  // TODO: Tambahkan fungsi login di sini
  void login() {
    // contoh
    print("Login tapped");
  }
}
