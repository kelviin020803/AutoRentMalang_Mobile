import 'package:get/get.dart'; //get x biar data bisa update otomatis di ui
import '../models/mobil_model.dart'; //untuk bentuk data mobil
import '../services/api_service.dart'; //untuk manggil api nya

class MobilController extends GetxController {
  var mobilList = <Mobil>[].obs; //tempat menyimpan data mobil dari api
  var loading = false.obs; //penanda saat mengambil data, true saat loading
  var error = ''.obs; //nyimpan pesan kalau ada error,

  // fetch using http + async-await, jadi ini fungsi untuk mengambil data api makai library http
  Future<void> fetchWithHttp() async {
    loading.value = true;
    error.value = '';
    mobilList.clear();
    try {
      final data = await ApiService.getMobilHttp();
      final list = data.map((e) => Mobil.fromJson(e)).toList();
      mobilList.assignAll(list);
    } catch (e) {
      error.value = e.toString();
    } finally {
      loading.value = false;
    }
  }

  // fetch using dio +
  Future<void> fetchWithDio() async {
    loading.value = true;
    error.value = '';
    mobilList.clear();
    try {
      final data = await ApiService.getMobilDio();
      final list = data.map((e) => Mobil.fromJson(e)).toList();
      mobilList.assignAll(list);
    } catch (e) {
      error.value = e.toString();
    } finally {
      loading.value = false;
    }
  }
}
