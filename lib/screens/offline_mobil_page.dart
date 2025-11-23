import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/hive_controller.dart';
import '../models/mobil_model.dart';

class OfflineMobilPage extends StatelessWidget {
  const OfflineMobilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HiveController>();
    controller.load();
    return Scaffold(
      appBar: AppBar(title: const Text('Mobil Offline (Hive)')),
      body: Obx(() {
        if (controller.list.isEmpty) {
          return const Center(child: Text('Tidak ada cache'));
        }
        return ListView.separated(
          itemCount: controller.list.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (_, i) {
            final Mobil m = controller.list[i];
            return ListTile(
              title: Text(m.nama),
              subtitle: Text(m.harga),
            );
          },
        );
      }),
    );
  }
}