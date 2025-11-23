import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'controllers/prefs_controller.dart';
import 'controllers/mobil_controller.dart';
import 'controllers/hive_controller.dart';
import 'controllers/supabase_mobil_controller.dart';
import 'services/hive_service.dart';
import 'utils/app_theme.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  await HiveService.init(); // BUKAN initHive()
  
  // Initialize Supabase (ganti dengan URL dan anonKey Supabase kamu)
  await Supabase.initialize(
    url: 'https://usjtxverhfbjhqxrqpkc.supabase.co', // Ganti dengan URL Supabase kamu
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVzanR4dmVyaGZiamhxeHJxcGtjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjMzMDY4NjAsImV4cCI6MjA3ODg4Mjg2MH0.Ynx0lta4cYLZWoV_VsJ3hOxACD8IyjGoo57eHmmxgdw', // Ganti dengan anon key kamu
  );
  
  // Initialize controllers
  Get.put(PrefsController());
  Get.put(MobilController()); // BUKAN mobilController() - huruf besar M
  Get.put(HiveController());
  Get.put(SupabaseMobilController());
  
  runApp(const RentalMobilApp());
}

class RentalMobilApp extends StatelessWidget {
  const RentalMobilApp({super.key});

  @override
  Widget build(BuildContext context) {
    final prefs = Get.find<PrefsController>();
    return Obx(() => GetMaterialApp(
          title: "Rental Mobil",
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: prefs.isDark.value ? ThemeMode.dark : ThemeMode.light,
          initialRoute: Routes.home,
          getPages: AppRoutes.pages,
          debugShowCheckedModeBanner: false,
        ));
  }
}