import 'package:get/get.dart';
import '../models/mobil_model.dart';
import '../services/api_service.dart';
import '../services/hive_service.dart';

class MobilController extends GetxController {
  var mobilList = <Mobil>[].obs;
  var loading = false.obs;
  var error = ''.obs;

  Future<void> fetchWithHttp() async {
    loading.value = true;
    error.value = '';
    try {
      final jsonData = await ApiService.getMobilHttp();
      final list = jsonData.map<Mobil>((e) => Mobil.fromJson(e)).toList();
      mobilList.assignAll(list);
      // Cache ke Hive
      await HiveService.saveAll(list);
    } catch (e) {
      error.value = e.toString();
      // Load dari cache jika gagal
      final cached = HiveService.getAll();
      if (cached.isNotEmpty) {
        mobilList.assignAll(cached);
      }
    } finally {
      loading.value = false;
    }
  }

  Future<void> fetchWithDio() async {
    loading.value = true;
    error.value = '';
    try {
      final jsonData = await ApiService.getMobilDio();
      final list = jsonData.map<Mobil>((e) => Mobil.fromJson(e)).toList();
      mobilList.assignAll(list);
      // Cache ke Hive
      await HiveService.saveAll(list);
    } catch (e) {
      error.value = e.toString();
      // Load dari cache jika gagal
      final cached = HiveService.getAll();
      if (cached.isNotEmpty) {
        mobilList.assignAll(cached);
      }
    } finally {
      loading.value = false;
    }
  }
}