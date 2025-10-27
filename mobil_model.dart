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
    // jsonplaceholder post -> map to Mobil
    final title = json['title'] ?? '';
    // Create a fake price based on id to make UI look realistic
    final price = 'Rp \${(json['id'] ?? 1) * 100000} / hari';
    return Mobil(
      id: json['id'] ?? 0,
      nama: title,
      harga: price,
      body: json['body'] ?? '',
    );
  }
}
