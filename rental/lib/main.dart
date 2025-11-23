import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/home_page.dart';
import 'controllers/mobil_controller.dart';

void main() {
  // Initialize controller
  Get.put(MobilController());
  runApp(const RentalMobilApp());
}

class RentalMobilApp extends StatelessWidget {
  const RentalMobilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Rental Mobil - Modul 3",
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blueAccent),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
