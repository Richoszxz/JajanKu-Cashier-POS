import 'package:jajanku_pos/models/product_model.dart';
import 'supabase_client.dart';

class ProductServices {
  final _supabase = SupabaseManager.client;

  // CREATE
  Future<void> tambahProduk(Produk produk) async {
    final response = await _supabase.from('produk').insert(produk.toMap());
    if (response.error != null) {
      throw Exception('Gagal menambahkan produk: ${response.error!.message}');
    }
  }

  // READ
  Future<List<Produk>> lihatProduk() async {
    try {
      final response = await _supabase.from('produk').select();

      return (response as List<dynamic>)
          .map((item) => Produk.fromMap(item))
          .toList();
    } on Exception catch (e) {
      throw Exception('Gagal mengambil produk $e');
    }
  }

  // UPDATE
  Future<void> editProduk(int id, Produk produk) async {
    final response = await _supabase
        .from('produk')
        .update(produk.toMap())
        .eq("id", id);
    if (response.error != null) {
      throw Exception('Gagal mengedit produk: ${response.error!.message}');
    }
  }

  // DELETE
  Future<void> hapusProduk(int id) async {
    try {
      _supabase.from('produk').delete().eq("id", id);
    } on Exception catch (e) {
      throw Exception('Gagal menghapus produk: $e');
    }
  }
}