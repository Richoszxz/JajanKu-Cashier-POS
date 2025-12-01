class Pelanggan {
  final int? id;
  final String? kodePelanggan;
  final String namaPelanggan;
  final String emailPelanggan;
  final String nomoHandphonePelanggan;
  final int? totalTransaksiPelanggan;
  final DateTime? terakhirTransaksi;
  final DateTime? tanggalRegistrasi;

  Pelanggan({
    this.id,
    this.kodePelanggan,
    required this.namaPelanggan,
    required this.emailPelanggan,
    required this.nomoHandphonePelanggan,
    this.totalTransaksiPelanggan,
    this.terakhirTransaksi,
    this.tanggalRegistrasi
  });

  factory Pelanggan.fromMap(Map<String, dynamic> map) {
    return Pelanggan(
      id: map['id'],
      kodePelanggan: map['kode_pelanggan'] ?? "",
      namaPelanggan: map['nama_pelanggan'] ?? "",
      emailPelanggan: map['email'] ?? "",
      nomoHandphonePelanggan: map['no_handphone'] ?? "",
      totalTransaksiPelanggan: map['total_transaksi'] ?? 0,
      terakhirTransaksi: DateTime.parse(map['terakhir_transaksi'] ?? DateTime.now().toIso8601String()),
      tanggalRegistrasi: DateTime.parse(map['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  /// toMap khusus INSERT → hanya kirim field yg user isi
  Map<String, dynamic> toInsertMap() {
    return {
      'kode_pelanggan': kodePelanggan,
      'nama_pelanggan': namaPelanggan,
      'email': emailPelanggan,
      'no_handphone': nomoHandphonePelanggan,
      // NOT sending: id, created_at, total_transaksi, terakhir_transaksi
    };
  }

  /// toMap khusus UPDATE → id tidak ikut dikirim, created_at tidak ikut dikirim
  Map<String, dynamic> toUpdateMap() {
    return {
      'nama_pelanggan': namaPelanggan,
      'email': emailPelanggan,
      'no_handphone': nomoHandphonePelanggan,
    };
  }
}