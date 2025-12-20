import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // REGISTER
  Future<void> register({
    required String email,
    required String password,
    required String role,
    String? name,
  }) async {
    final authResponse = await _supabase.auth.signUp(
      email: email,
      password: password,
    );

    final user = authResponse.user;
    if (user == null) {
      throw Exception('Register failed');
    }

    await _supabase.from('profiles').insert({
      'id': user.id,
      'email': user.email,
      'name': name,
      'role': role,
    });
  }

  // LOGIN
  Future<String> login({
    required String email,
    required String password,
  }) async {
    final authResponse = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final user = authResponse.user;
    if (user == null) {
      throw Exception('Login failed');
    }

    final profile = await _supabase
        .from('profiles')
        .select('role')
        .eq('id', user.id)
        .single();

    return profile['role'];
  }

  // LOGOUT
  Future<void> logout() async {
    await _supabase.auth.signOut();
  }
}
