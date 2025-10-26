import 'package:flutter/material.dart';

class DaftarMobilPage extends StatefulWidget {
  const DaftarMobilPage({super.key});

  @override
  State<DaftarMobilPage> createState() => _DaftarMobilPageState();
}

class _DaftarMobilPageState extends State<DaftarMobilPage>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> mobilList = [
    {"nama": "Toyota Avanza", "harga": "Rp 400.000 / hari"},
    {"nama": "Honda Brio", "harga": "Rp 350.000 / hari"},
    {"nama": "Mitsubishi Xpander", "harga": "Rp 500.000 / hari"},
    {"nama": "Suzuki Ertiga", "harga": "Rp 450.000 / hari"},
  ];

  int? selectedIndex;

  // Animasi eksplisit
  late AnimationController _controller;
  late Animation<double> _moveAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _moveAnim = Tween<double>(
      begin: 0,
      end: 200,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sewaMobil() {
    if (selectedIndex == null) return;
    _controller.forward(from: 0);

    // Setelah animasi selesai, pindah ke halaman detail mobil
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailMobilPage(mobil: mobilList[selectedIndex!]),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth < 600 ? 2 : (screenWidth < 1000 ? 3 : 4);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Mobil untuk Disewa"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
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
                  itemCount: mobilList.length,
                  itemBuilder: (context, index) {
                    final mobil = mobilList[index];
                    final bool isSelected = selectedIndex == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = selectedIndex == index ? null : index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
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
                              tag: mobil["nama"],
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
                              mobil["nama"],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: isSelected ? 17 : 15,
                              ),
                            ),
                            Text(
                              mobil["harga"],
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // Animasi eksplisit (ikon mobil bergerak)
          AnimatedBuilder(
            animation: _moveAnim,
            builder: (context, child) {
              return Container(
                height: 120,
                width: double.infinity,
                color: Colors.grey.shade100,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Positioned(
                      left: _moveAnim.value,
                      child: const Icon(
                        Icons.directions_car_filled,
                        size: 70,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: ElevatedButton.icon(
              onPressed: selectedIndex != null ? _sewaMobil : null,
              icon: const Icon(Icons.key),
              label: const Text("Sewa Mobil Ini"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.blueAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =======================
// Halaman Detail Mobil
// =======================
class DetailMobilPage extends StatelessWidget {
  final Map<String, dynamic> mobil;

  const DetailMobilPage({super.key, required this.mobil});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mobil["nama"]),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: mobil["nama"],
              child: const Icon(
                Icons.directions_car,
                size: 120,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              mobil["nama"],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              mobil["harga"],
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text("Kembali"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
