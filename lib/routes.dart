import 'package:get/get.dart';
import 'screens/home_page.dart';
import 'screens/daftar_mobil_page.dart';
import 'screens/offline_mobil_page.dart';
import 'screens/cloud_mobil_page.dart';
import 'screens/settings_page.dart' as app_settings;

class Routes {
  static const home = '/';
  static const daftar = '/daftar';
  static const offline = '/offline';
  static const cloud = '/cloud';
  static const settings = '/settings';
}

class AppRoutes {
  static final pages = [
    GetPage(name: Routes.home, page: () => const HomePage()),
    GetPage(name: Routes.daftar, page: () => const DaftarMobilPage()),
    GetPage(name: Routes.offline, page: () => const OfflineMobilPage()),
    GetPage(name: Routes.cloud, page: () =>  CloudMobilPage()),
    GetPage(name: Routes.settings, page: () => const app_settings.SettingsPage()),
  ];
}