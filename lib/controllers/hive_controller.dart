import 'package:get/get.dart';
import '../models/mobil_model.dart';
import '../services/hive_service.dart';

class HiveController extends GetxController {
  var list = <Mobil>[].obs;

  void load() {
    final cached = HiveService.getAll();
    list.assignAll(cached);
  }

  Future<void> clearCache() async {
    await HiveService.clearAll();
    load();
  }
}