import 'dart:async';
import 'package:flutter/material.dart';

class JupiterPulsePage extends StatefulWidget {
  const JupiterPulsePage({super.key});

  @override
  State<JupiterPulsePage> createState() => _JupiterPulsePageState();
}

class _JupiterPulsePageState extends State<JupiterPulsePage> {
  bool _expanded = false;
  Timer? _pulseTimer;

  @override
  void initState() {
    super.initState();
    _pulseTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _expanded = !_expanded;
      });
    });
  }

  @override
  void dispose() {
    _pulseTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jupiter Pulsing"),
        backgroundColor: Colors.brown,
      ),
      backgroundColor: Colors.grey[900],
      body: Row(
        children: [
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
                    "Animation:\nPulsating Jupiter",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "🪐 Jupiter expands and contracts every 3 seconds.\n\n"
                    "💫 This is an implicit animation powered using AnimatedContainer.\n\n",
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
          Flexible(
            flex: 2,
            child: Container(
              color: Colors.black,
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(seconds: 3),
                  curve: Curves.easeInOut,
                  width: _expanded ? 250 : 180,
                  height: _expanded ? 250 : 180,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.brown,
                        blurRadius: 25,
                        spreadRadius: 8,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      "assets/jupiter.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
