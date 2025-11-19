import 'supabase_client.dart';

class ProfileServices {
  final _client = SupabaseManager.client;

  Future<Map<String, dynamic>?> getUsers() async {
    final userId = _client.auth.currentUser?.id;

    if (userId == null) return null;

    final response = _client.from("users").select().eq('id', userId).single();

    return response;
  }
}
