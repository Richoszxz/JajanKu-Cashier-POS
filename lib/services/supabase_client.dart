import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseManager {
  static const String _supabaseUrl = 'https://kvbbwvuyhajequwvyfvt.supabase.co';
  static const String _supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imt2YmJ3dnV5aGFqZXF1d3Z5ZnZ0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjA5ODY3NjcsImV4cCI6MjA3NjU2Mjc2N30.gwvhr4AOuyUxRyPcTKT1DEgy42e4RtXtElzWolaIzEU';

  static Future<void> init() async {
    await Supabase.initialize(
      url: _supabaseUrl,
      anonKey: _supabaseAnonKey,
      authOptions: FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce
      ),
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}