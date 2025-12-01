import 'package:jajanku_pos/models/product_model.dart';
import 'package:jajanku_pos/models/category_models.dart';
import 'supabase_client.dart';

class ProductServices {
  final _supabase = SupabaseManager.client;

  // CREATE
  Future<void> tambahProduk(Produk produk) async {
    try {
      await _supabase.from('produk').insert(produk.toInsertMap());
    } catch (e) {
      throw Exception("Gagal menambahkan produk: $e");
    }
  }

  // Generate Kode Produk berdasarkan ID terakhir
  Future<String> generateKodeProdukById() async {
    try {
      final response = await _supabase
          .from('produk')
          .select('id')
          .order('id', ascending: false)
          .limit(1);

      int nextId = 1;

      if (response.isNotEmpty) {
        nextId = (response.first['id'] as int) + 1;
      }

      return "PRD${nextId.toString().padLeft(6, '0')}";
    } catch (e) {
      throw Exception("Gagal generate kode produk: $e");
    }
  }

  // READ
  Future<List<Produk>> lihatProduk() async {
    try {
      final response = await _supabase.from('produk').select();

      return (response as List<dynamic>)
          .map((item) => Produk.fromMap(item))
          .toList();
    } catch (e) {
      throw Exception("Gagal mengambil data produk: $e");
    }
  }

  // UPDATE
  Future<void> editProduk(int id, Produk produk) async {
    try {
      await _supabase
          .from('produk')
          .update(produk.toUpdateMap())
          .eq('id', id);
    } catch (e) {
      throw Exception("Gagal mengedit produk: $e");
    }
  }

  // DELETE
  Future<void> hapusProduk(int id) async {
    try {
      await _supabase.from('produk').delete().eq("id", id);
    } catch (e) {
      throw Exception("Gagal menghapus produk: $e");
    }
  }

  // AMBIL DATA KATEGORI
  Future<List<CategoryModel>> ambilKategori() async {
    try {
      final response = await _supabase.from("kategori").select();

      return (response as List<dynamic>)
          .map((item) => CategoryModel.fromJson(item))
          .toList();
    } catch (e) {
      throw Exception("Gagal mengambil kategori: $e");
    }
  }
}
