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

  // generate kode pelanggan berdasarkan ID terakhir
  Future<String> generateKodePelangganById() async {
    try {
      final response = await _supabase
          .from('pelanggan')
          .select('id')
          .order('id', ascending: false)
          .limit(1);

      int nextId = 1;
      if (response.isNotEmpty) {
        nextId = (response.first['id'] as int) + 1;
      }

      return "CSR${nextId.toString().padLeft(6, '0')}";
    } catch (e) {
      throw Exception("Gagal generate kode pelanggan: $e");
    }
  }

  // tambah
  Future<void> tambahCustomer(Pelanggan pelanggan) async {
    try {
      await _supabase.from('pelanggan').insert(pelanggan.toInsertMap());
    } catch (e) {
      throw Exception('Gagal menambah customer: $e');
    }
  }

  // update
  Future<void> updateCustomer(int id, Pelanggan pelanggan) async {
    try {
      await _supabase
          .from('pelanggan')
          .update(pelanggan.toUpdateMap())
          .eq('id', id);
    } catch (e) {
      throw Exception('Gagal memperbarui customer: $e');
    }
  }

  // delete
  Future<void> hapusCustomer(int id) async {
    try {
      await _supabase.from('pelanggan').delete().eq('id', id);
    } catch (e) {
      throw Exception('Gagal menghapus customer: $e');
    }
  }
}
