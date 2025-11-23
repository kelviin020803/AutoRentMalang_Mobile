import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/mobil_model.dart';

class SupabaseService {
  static final client = Supabase.instance.client;

  // ============================
  // GET / FETCH
  // ============================
  static Future<List<Mobil>> fetchMobils() async {
    final response = await client.from('mobils').select().order('id');

    return (response as List).map<Mobil>((e) => Mobil(
      id: e['id'],
      nama: e['nama'],
      harga: e['harga'],
      body: e['body'],
    )).toList();
  }

  // ============================
  // ADD
  // ============================
  static Future<void> addMobil(Mobil m) async {
    final data = {
      'id': m.id,
      'nama': m.nama,
      'harga': m.harga,
      'body': m.body,
    };

    await client.from('mobils').insert(data);
  }

  // ============================
  // UPDATE
  // ============================
  static Future<void> updateMobil(Mobil m) async {
    final data = {
      'nama': m.nama,
      'harga': m.harga,
      'body': m.body,
    };

    await client.from('mobils').update(data).eq('id', m.id);
  }

  // ============================
  // DELETE
  // ============================
  static Future<void> deleteMobil(int id) async {
    await client.from('mobils').delete().eq('id', id);
  }
}