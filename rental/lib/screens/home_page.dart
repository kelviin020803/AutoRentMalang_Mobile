import 'package:flutter/material.dart';
import 'daftar_mobil_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Rental Mobil - Beranda"),
        backgroundColor: color,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: "logoRental",
              child: Icon(Icons.directions_car_filled, size: 100, color: color),
            ),
            const SizedBox(height: 30),
            const Text(
              "Selamat Datang di Aplikasi Rental Mobil",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              icon: const Icon(Icons.list),
              label: const Text("Lihat Daftar Mobil (HTTP)"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DaftarMobilPage(useDio: false)),
                );
              },
            ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              icon: const Icon(Icons.cloud_sync),
              label: const Text("Lihat Daftar Mobil (Dio)"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DaftarMobilPage(useDio: true)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
