import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Mobil extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String nama;
  @HiveField(2)
  final String harga;
  @HiveField(3)
  final String body;

  Mobil({
    required this.id,
    required this.nama,
    required this.harga,
    required this.body,
  });

  factory Mobil.fromJson(Map<String, dynamic> json) {
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
    final idx = (json['id'] ?? 1) is int
        ? (json['id'] ?? 1) as int
        : int.tryParse('${json['id']}') ?? 1;
    final namaMobil = dummyCars[idx % dummyCars.length];
    final harga = 'Rp ${idx * 100000} / hari';
    return Mobil(
      id: idx,
      nama: namaMobil,
      harga: harga,
      body: json['body'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'harga': harga,
      'body': body,
    };
  }
}

// Manual Hive adapter
class MobilHiveAdapter extends TypeAdapter<Mobil> {
  @override
  final int typeId = 0;

  @override
  Mobil read(BinaryReader reader) {
    final id = reader.readInt();
    final nama = reader.readString();
    final harga = reader.readString();
    final body = reader.readString();
    return Mobil(id: id, nama: nama, harga: harga, body: body);
  }

  @override
  void write(BinaryWriter writer, Mobil obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.nama);
    writer.writeString(obj.harga);
    writer.writeString(obj.body);
  }
}