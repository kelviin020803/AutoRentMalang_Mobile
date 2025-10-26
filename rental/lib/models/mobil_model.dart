class Mobil {
  final int id;
  final String nama;
  final String harga;
  final String body;

  Mobil({
    required this.id,
    required this.nama,
    required this.harga,
    required this.body,
  });

  factory Mobil.fromJson(Map<String, dynamic> json) {
    // Ubah title palsu menjadi nama mobil realistis
    final dummyCars = [
      'Toyota Avanza',
      'Honda Brio',
      'Suzuki Ertiga',
      'Mitsubishi Xpander',
      'Daihatsu Sigra',
      'Toyota Innova',
      'Honda Jazz',
      'Nissan Livina',
      'Wuling Confero',
      'Hyundai Stargazer',
    ];

    // Ambil salah satu nama mobil dari daftar di atas berdasarkan id
    final namaMobil = dummyCars[(json['id'] ?? 1) % dummyCars.length];
    final harga = 'Rp ${(json['id'] ?? 1) * 100000} / hari';

    return Mobil(
      id: json['id'] ?? 0,
      nama: namaMobil,
      harga: harga,
      body: json['body'] ?? '',
    );
  }
}
