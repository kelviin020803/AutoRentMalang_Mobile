import 'package:flutter/material.dart';

class AnimasiEksplisitPage extends StatefulWidget {
  const AnimasiEksplisitPage({super.key});

  @override
  State<AnimasiEksplisitPage> createState() => _AnimasiEksplisitPageState();
}

class _AnimasiEksplisitPageState extends State<AnimasiEksplisitPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnim;
  late Animation<Color?> _colorAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _sizeAnim = Tween<double>(begin: 150, end: 250).animate(_controller);
    _colorAnim = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contoh Animasi Eksplisit")),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              width: _sizeAnim.value,
              height: _sizeAnim.value,
              decoration: BoxDecoration(
                color: _colorAnim.value,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.car_rental,
                color: Colors.white,
                size: 50,
              ),
            );
          },
        ),
      ),
    );
  }
}
