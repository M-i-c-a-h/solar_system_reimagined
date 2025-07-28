import 'package:flutter/material.dart';
import 'dart:math';

class UranusPage extends StatefulWidget {
  const UranusPage({super.key});

  @override
  State<UranusPage> createState() => _UranusPageState();
}

class _UranusPageState extends State<UranusPage>
    with SingleTickerProviderStateMixin {
  double _fogOpacity = 0.0;
  late AnimationController _controller;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _fogOpacity = 0.9;
      });
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true); // floating effect
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> buildIceCrystals() {
    return List.generate(8, (index) {
      final left = _random.nextDouble() * 300;
      final size = _random.nextDouble() * 10 + 5;
      return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Positioned(
            left: left,
            top: 200 + sin(_controller.value * 2 * pi + index) * 30,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                shape: BoxShape.circle,
              ),
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Uranus: The Icy Giant"),
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.grey[900],
      body: Row(
        children: [
          // Left Description Panel
          Flexible(
            flex: 1,
            child: Container(
              color: Colors.blueGrey[100],
              padding: const EdgeInsets.all(24),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Animation:\nIcy Fog & Crystals",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "❄️ A soft fog fades in around Uranus.\n\n"
                    "🔵 Floating ice crystals hover in a loop.\n\n"
                    "🌫️ Combines opacity and radial gradients for a cold aesthetic.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Right Animation Panel
          Flexible(
            flex: 2,
            child: Container(
              color: Colors.black26,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Uranus image
                  Image.asset(
                    "assets/uranus.jpg",
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  // Fog
                  AnimatedOpacity(
                    opacity: _fogOpacity,
                    duration: const Duration(seconds: 3),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [
                            Colors.white.withOpacity(0.8),
                            Colors.lightBlueAccent.withOpacity(0.5),
                            Colors.transparent,
                          ],
                          stops: [0.2, 0.6, 1.0],
                          radius: 0.9,
                        ),
                      ),
                    ),
                  ),
                  // Floating crystals
                  ...buildIceCrystals(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
