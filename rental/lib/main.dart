import 'package:flutter/material.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const RentalMobilApp());
}

class RentalMobilApp extends StatelessWidget {
  const RentalMobilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Rental Mobil Responsif",
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blueAccent),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
