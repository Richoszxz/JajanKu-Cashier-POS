class Pelanggan {
  final int id;
  final String kodePelanggan;
  final String namaPelanggan;
  final String emailPelanggan;
  final String nomoHandphonePelanggan;
  final int totalTransaksiPelanggan;
  final DateTime terakhirTransaksi;

  Pelanggan({
    required this.id,
    required this.kodePelanggan,
    required this.namaPelanggan,
    required this.emailPelanggan,
    required this.nomoHandphonePelanggan,
    required this.totalTransaksiPelanggan,
    required this.terakhirTransaksi,
  });

  factory Pelanggan.fromMap(Map<String, dynamic> map) {
    return Pelanggan(
      id: map['id'] ?? 0,
      kodePelanggan: map['kode_pelanggan'] ?? "",
      namaPelanggan: map['nama_pelanggan'] ?? "",
      emailPelanggan: map['email'] ?? "",
      nomoHandphonePelanggan: map['no_handphone'] ?? "",
      totalTransaksiPelanggan: map['total_transaksi'] ?? 0,
      terakhirTransaksi: DateTime.parse(map['terakhir_transaksi'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'kode_pelanggan': kodePelanggan,
      'nama_pelanggan': namaPelanggan,
      'email': emailPelanggan,
      'no_handphone': nomoHandphonePelanggan,
      'total_transaksi': totalTransaksiPelanggan,
      'terakhir_transaksi': terakhirTransaksi.toIso8601String(),
    };
  }
}