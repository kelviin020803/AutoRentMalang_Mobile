import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/mobil_controller.dart';
import 'detail_mobil_page.dart';

class DaftarMobilPage extends StatefulWidget {
  const DaftarMobilPage({super.key});

  @override
  State<DaftarMobilPage> createState() => _DaftarMobilPageState();
}

class _DaftarMobilPageState extends State<DaftarMobilPage> {
  final MobilController controller = Get.find<MobilController>();

  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    controller.fetchWithHttp();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth < 600 ? 2 : (screenWidth < 1000 ? 3 : 4);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Mobil (HTTP/Dio)'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Obx(() {
            if (controller.loading.value) {
              return const LinearProgressIndicator();
            } else if (controller.error.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  'Error: ${controller.error.value}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else {
              return const SizedBox(height: 4);
            }
          }),
          Expanded(
            child: Obx(() {
              final list = controller.mobilList;
              if (list.isEmpty && !controller.loading.value) {
                return const Center(
                  child: Text('Tidak ada data. Tekan tombol refresh jika perlu.'),
                );
              }
              return LayoutBuilder(
                builder: (context, constraints) {
                  double itemWidth = constraints.maxWidth / crossAxisCount;
                  return GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: itemWidth / 200,
                    ),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final mobil = list[index];
                      final bool isSelected = selectedIndex == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = selectedIndex == index ? null : index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.blueAccent.shade100
                                : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.blueAccent
                                  : Colors.grey.shade300,
                              width: 2,
                            ),
                            boxShadow: [
                              if (isSelected)
                                const BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Hero(
                                tag: 'mobil_${mobil.id}',
                                child: Icon(
                                  Icons.directions_car,
                                  size: isSelected ? 60 : 45,
                                  color: isSelected
                                      ? Colors.blueAccent
                                      : Colors.grey.shade700,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                mobil.nama,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: isSelected ? 17 : 15,
                                ),
                              ),
                              Text(
                                mobil.harga,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: selectedIndex != null
                        ? () {
                            final mobil = controller.mobilList[selectedIndex!];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailMobilPage(mobil: mobil),
                              ),
                            );
                          }
                        : null,
                    icon: const Icon(Icons.key),
                    label: const Text("Sewa Mobil Ini"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.blueAccent,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    controller.fetchWithHttp();
                  },
                  child: const Text('Refresh'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}