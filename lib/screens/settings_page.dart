import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/prefs_controller.dart';
import '../controllers/hive_controller.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final prefs = Get.find<PrefsController>();
    final hiveC = Get.find<HiveController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Obx(() => SwitchListTile(
                  title: const Text('Dark Mode'),
                  value: prefs.isDark.value,
                  onChanged: (v) => prefs.setDark(v),
                )),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                await hiveC.clearCache();
                Get.snackbar('Info', 'Cache Hive dibersihkan');
              },
              child: const Text('Hapus Cache (Hive)'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Kembali'),
            )
          ],
        ),
      ),
    );
  }
}