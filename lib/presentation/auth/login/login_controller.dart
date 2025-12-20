import 'package:flutter/material.dart';
import '../../../data/services/auth_service.dart';

class LoginController extends ChangeNotifier {
  final AuthService _authService = AuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

  bool get obscurePassword => _obscurePassword;
  bool get isLoading => _isLoading;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  Future<String?> login() async {
    _isLoading = true;
    notifyListeners();

    try {
      final role = await _authService.login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      return role;
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
