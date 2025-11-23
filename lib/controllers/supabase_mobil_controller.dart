import 'package:get/get.dart';
import '../models/mobil_model.dart';
import '../services/supabase_service.dart';

class SupabaseMobilController extends GetxController {
  var list = <Mobil>[].obs;
  var loading = false.obs;
  var error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetch();
  }

  Future<void> fetch() async {
    loading.value = true;
    error.value = '';
    try {
      final data = await SupabaseService.fetchMobils();
      list.assignAll(data);
    } catch (e) {
      error.value = e.toString();
    } finally {
      loading.value = false;
    }
  }

  Future<void> add(Mobil m) async {
    loading.value = true;
    error.value = '';
    try {
      await SupabaseService.addMobil(m);
      await fetch();
    } catch (e) {
      error.value = e.toString();
    } finally {
      loading.value = false;
    }
  }

  Future<void> updateMobil(Mobil m) async {
    loading.value = true;
    error.value = '';
    try {
      await SupabaseService.updateMobil(m);
      await fetch();
    } catch (e) {
      error.value = e.toString();
    } finally {
      loading.value = false;
    }
  }

  Future<void> delete(int id) async {
    loading.value = true;
    error.value = '';
    try {
      await SupabaseService.deleteMobil(id);
      await fetch();
    } catch (e) {
      error.value = e.toString();
    } finally {
      loading.value = false;
    }
  }
}