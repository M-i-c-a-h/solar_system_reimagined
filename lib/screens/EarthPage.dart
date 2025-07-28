import 'dart:math';
import 'package:flutter/material.dart';

class EarthOrbitPage extends StatefulWidget {
  const EarthOrbitPage({super.key});

  @override
  State<EarthOrbitPage> createState() => _EarthOrbitPageState();
}

class _EarthOrbitPageState extends State<EarthOrbitPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _orbitAnimation;

  bool isReversed = false;
  bool isAnimating = true;

  double begin = 0.0;
  double end = 1.0;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
    _controller.repeat();
  }

  void _setupAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    );

    _orbitAnimation = Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  void togglePlayPause() {
    setState(() {
      if (isAnimating) {
        _controller.stop();
      } else {
        _controller.repeat();
      }
      isAnimating = !isAnimating;
    });
  }

  void reverseDirection() {
    setState(() {
      // Swap direction
      final oldBegin = begin;
      begin = end;
      end = oldBegin;
      isReversed = !isReversed;

      _orbitAnimation = Tween<double>(begin: begin, end: end).animate(
        CurvedAnimation(parent: _controller, curve: Curves.linear),
      );

      _controller.reset();
      if (isAnimating) {
        _controller.repeat();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Earth & Moon Orbit"),
        backgroundColor: Colors.brown,
      ),
      backgroundColor: Colors.grey[900],
      body: Row(
        children: [
          // Left Info Panel
          Flexible(
            flex: 1,
            child: Container(
              color: Colors.brown[300],
              padding: const EdgeInsets.all(16.0),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Animation:\nEarth & Moon Orbiting",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "🌍 Earth rotates slowly\n🌕 Moon orbits Earth\n\n▶️ Pause/Play: Start or stop animation\n↔️ Reverse: Change orbit direction",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.left,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    height: 200,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Rotating Earth
                        AnimatedBuilder(
                          animation: _orbitAnimation,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: 2 * pi * _orbitAnimation.value,
                              child: child,
                            );
                          },
                          child: ClipOval(
                            child: Image.asset(
                              "assets/earth.jpg",
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Orbiting Moon
                        AnimatedBuilder(
                          animation: _orbitAnimation,
                          builder: (context, child) {
                            final angle = 2 * pi * _orbitAnimation.value;
                            final radius = 120.0;
                            return Transform.translate(
                              offset: Offset(
                                radius * cos(angle),
                                radius * sin(angle),
                              ),
                              child: child,
                            );
                          },
                          child: ClipOval(
                            child: Image.asset(
                              "assets/moon.jpg",
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Control Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 36,
                        icon:
                            Icon(isAnimating ? Icons.pause : Icons.play_arrow),
                        onPressed: togglePlayPause,
                        tooltip: isAnimating ? "Pause" : "Play",
                      ),
                      const SizedBox(width: 30),
                      IconButton(
                        iconSize: 36,
                        icon: const Icon(Icons.swap_horiz),
                        onPressed: reverseDirection,
                        tooltip: "Reverse Orbit",
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
