import 'package:flutter/material.dart';

class AnimasiImplisitPage extends StatefulWidget {
  const AnimasiImplisitPage({super.key});

  @override
  State<AnimasiImplisitPage> createState() => _AnimasiImplisitPageState();
}

class _AnimasiImplisitPageState extends State<AnimasiImplisitPage> {
  double _size = 150;
  Color _color = Colors.blueAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contoh Animasi Implisit")),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _size = _size == 150 ? 250 : 150;
              _color = _color == Colors.blueAccent
                  ? Colors.orangeAccent
                  : Colors.blueAccent;
            });
          },
          child: AnimatedContainer(
            width: _size,
            height: _size,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: _color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.car_rental, color: Colors.white, size: 50),
          ),
        ),
      ),
    );
  }
}
