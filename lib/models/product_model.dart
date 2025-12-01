class Produk {
  final int? id;
  final String? kodeProduk;
  final String namaProduk;
  final double hargaProduk;
  final int kategoriId;
  final int stokProduk;
  final String? deskripsiProduk;
  final String? gambarProduk;

  Produk({
    this.id,
    this.kodeProduk,
    required this.namaProduk,
    required this.hargaProduk,
    required this.kategoriId,
    required this.stokProduk,
    this.deskripsiProduk,
    this.gambarProduk,
  });

  factory Produk.fromMap(Map<String, dynamic> map) {
    return Produk(
      id: map['id'] ?? 0,
      kodeProduk: map['kode_produk'] ?? "",
      namaProduk: map['nama_produk'] ?? "",
      hargaProduk: map['harga'] ?? 0,
      kategoriId: map['kategori_id'] ?? 0,
      stokProduk: map['stok'] ?? 0,
      deskripsiProduk: map['deskripsi'] ?? "",
      gambarProduk: map['gambar_url'] ?? "",
    );
  }

  Map<String, dynamic> toInsertMap() {
    return {
      'kode_produk': kodeProduk,
      'nama_produk': namaProduk,
      'harga': hargaProduk,
      'stok': stokProduk,
      'kategori_id': kategoriId,
      'deskripsi': deskripsiProduk,
      'gambar_url': gambarProduk,
    };
  }

  Map<String, dynamic> toUpdateMap() {
    return {
      'nama_produk': namaProduk,
      'harga': hargaProduk,
      'kategori_id': kategoriId,
    };
  }
}
