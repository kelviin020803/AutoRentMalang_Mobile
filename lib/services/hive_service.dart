import 'package:hive/hive.dart';
import '../models/mobil_model.dart';

class HiveService {
  static const String boxName = "mobil_box";

  static Future<void> init() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(MobilHiveAdapter());
    }
    await Hive.openBox<Mobil>(boxName);
  }

  static Box<Mobil> _box() => Hive.box<Mobil>(boxName);

  static List<Mobil> getAll() => _box().values.toList();

  static Future<void> save(Mobil m) async {
    await _box().put(m.id, m);
  }

  static Future<void> saveAll(List<Mobil> list) async {
    final box = _box();
    await box.clear();
    for (var m in list) {
      await box.put(m.id, m);
    }
  }

  static Future<void> delete(int id) async {
    await _box().delete(id);
  }

  static Future<void> clearAll() async {
    await _box().clear();
  }
}