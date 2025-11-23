import 'package:get/get.dart';
import '../services/prefs_service.dart';

class PrefsController extends GetxController {
  var isDark = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final v = await PrefsService.getTheme();
    isDark.value = v;
  }

  void setDark(bool v) {
    isDark.value = v;
    PrefsService.setTheme(v);
  }
}