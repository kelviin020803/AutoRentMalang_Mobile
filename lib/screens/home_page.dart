import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/prefs_controller.dart';
import '../routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    final prefs = Get.find<PrefsController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rental Mobil - Beranda"),
        backgroundColor: color,
        centerTitle: true,
        actions: [
          Obx(() => Switch(
                value: prefs.isDark.value,
                onChanged: (v) => prefs.setDark(v),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: "logoRental",
              child: Icon(
                Icons.directions_car_filled,
                size: 100,
                color: color,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Selamat Datang di Aplikasi Rental Mobil",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.list),
              label: const Text("Daftar Mobil (HTTP/Dio)"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () => Get.toNamed(Routes.daftar),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.storage),
              label: const Text("Mobil Offline (Hive)"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () => Get.toNamed(Routes.offline),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.cloud),
              label: const Text("Mobil Cloud (Supabase)"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () => Get.toNamed(Routes.cloud),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.settings),
              label: const Text("Settings"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () => Get.toNamed(Routes.settings),
            ),
          ],
        ),
      ),
    );
  }
}