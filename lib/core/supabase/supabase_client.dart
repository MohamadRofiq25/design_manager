import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<void> testSupabaseConnection() async {
  try {
    final response = await supabase
        .from('test_connection')
        .select()
        .limit(1);

    print('Supabase OK: $response');
  } catch (e) {
    print('Supabase ERROR: $e');
  }
}