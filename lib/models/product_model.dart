class Produk {
  final int id;
  final String nama_produk;
  final String harga_produk;

  Produk({required this.id, required this.nama_produk, required this.harga_produk});

  factory Produk.fromMap(Map<String, dynamic> map) {
    return Produk(
      id: map['id'],
      nama_produk: map['nama_produk'],
      harga_produk: map['harga'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama_produk': nama_produk,
      'harga': harga_produk,
    };
  }
}