import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/supabase_mobil_controller.dart';
import '../models/mobil_model.dart';

class CloudMobilFormPage extends StatefulWidget {
  final Mobil? mobil;
  const CloudMobilFormPage({super.key, this.mobil});

  @override
  State<CloudMobilFormPage> createState() => _CloudMobilFormPageState();
}

class _CloudMobilFormPageState extends State<CloudMobilFormPage> {
  final namaC = TextEditingController();
  final hargaC = TextEditingController();
  final bodyC = TextEditingController();

  final controller = Get.find<SupabaseMobilController>();

  @override
  void initState() {
    super.initState();
    if (widget.mobil != null) {
      namaC.text = widget.mobil!.nama;
      hargaC.text = widget.mobil!.harga;
      bodyC.text = widget.mobil!.body;
    }
  }

  @override
  void dispose() {
    namaC.dispose();
    hargaC.dispose();
    bodyC.dispose();
    super.dispose();
  }

  bool _validate() {
    if (namaC.text.isEmpty || hargaC.text.isEmpty || bodyC.text.isEmpty) {
      Get.snackbar("Error", "Semua field wajib diisi");
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final bool isEdit = widget.mobil != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Edit Mobil" : "Tambah Mobil"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: namaC,
              decoration: const InputDecoration(labelText: "Nama Mobil"),
            ),
            TextField(
              controller: hargaC,
              decoration: const InputDecoration(labelText: "Harga"),
            ),
            TextField(
              controller: bodyC,
              decoration: const InputDecoration(labelText: "Body"),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                if (!_validate()) return;

                if (isEdit) {
                  await controller.updateMobil(
                    Mobil(
                      id: widget.mobil!.id,
                      nama: namaC.text,
                      harga: hargaC.text,
                      body: bodyC.text,
                    ),
                  );
                } else {
                  await controller.add(
                    Mobil(
                      id: DateTime.now().millisecondsSinceEpoch,
                      nama: namaC.text,
                      harga: hargaC.text,
                      body: bodyC.text,
                    ),
                  );
                }

                Get.back();
              },
              child: Text(isEdit ? "Update" : "Tambah"),
            )
          ],
        ),
      ),
    );
  }
}