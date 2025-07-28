import 'dart:async';

import 'package:flutter/material.dart';

class SaturnPage extends StatefulWidget {
  const SaturnPage({super.key});

  @override
  State<SaturnPage> createState() => _SaturnPageState();
}

class _SaturnPageState extends State<SaturnPage> {
  double _rotation = 0.0;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _rotation += 0.05;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // important!!!
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saturn Spinning Rings"),
        backgroundColor: Colors.brown,
      ),
      backgroundColor: Colors.grey[900],
      body: Row(
        children: [
          // Left Description Panel
          Flexible(
            flex: 1,
            child: Container(
              color: Colors.brown[200],
              padding: const EdgeInsets.all(24),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Animation:\nSpinning Saturn Rings",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "🪐 Saturn's rings rotate endlessly.\n\n"
                    "💫 This uses AnimatedRotation with timed updates.\n\n",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.5,
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
              color: Colors.black,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // Rotating Rings
                        AnimatedRotation(
                          turns: _rotation,
                          duration: const Duration(milliseconds: 50000),
                          child: Image.asset(
                            "assets/ring.jpg",
                            width: 250,
                            height: 250,
                          ),
                        ),
                        // Fixed Planet
                        Image.asset(
                          "assets/saturn.jpg",
                          width: 150,
                          height: 150,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "The spinning rings of Saturn",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 0),
                            blurRadius: 15,
                            color: Colors.blue.withOpacity(0.8),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
