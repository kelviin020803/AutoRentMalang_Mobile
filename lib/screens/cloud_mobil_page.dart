import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/supabase_mobil_controller.dart';
import 'cloud_mobil_form_page.dart';

class CloudMobilPage extends StatelessWidget {
  const CloudMobilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SupabaseMobilController>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cloud Mobil (Supabase)"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Get.to(() => const CloudMobilFormPage());
            },
          )
        ],
      ),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.error.isNotEmpty) {
          return Center(child: Text(controller.error.value));
        }

        if (controller.list.isEmpty) {
          return const Center(child: Text("Tidak ada mobil"));
        }

        return ListView.builder(
          itemCount: controller.list.length,
          itemBuilder: (context, index) {
            final m = controller.list[index];
            return ListTile(
              title: Text(m.nama),
              subtitle: Text(m.harga),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      Get.to(() => CloudMobilFormPage(mobil: m));
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      controller.delete(m.id);
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}