import 'package:flutter/material.dart';
import '../models/mobil_model.dart';

class DetailMobilPage extends StatelessWidget {
  final Mobil mobil;

  const DetailMobilPage({super.key, required this.mobil});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mobil.nama),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Hero(
              tag: mobil.nama,
              child: const Icon(
                Icons.directions_car,
                size: 120,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              mobil.nama,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              mobil.harga,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Text(
              mobil.body,
              style: const TextStyle(fontSize: 14),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text("Kembali"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
