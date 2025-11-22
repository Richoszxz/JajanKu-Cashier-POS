import 'package:jajanku_pos/models/customer_models.dart';
import 'supabase_client.dart';

class CustomerServices {
  final _supabase = SupabaseManager.client;

  // ambil
  Future<List<Pelanggan>> ambilCustomer() async {
    try {
      final response = await _supabase.from('pelanggan').select();

      return (response as List<dynamic>)
          .map((item) => Pelanggan.fromMap(item))
          .toList();
    } on Exception catch (e) {
      throw Exception('Gagal mengambil customer $e');
    }
  }
}