import 'package:flutter/material.dart';

class MarsDustPage extends StatefulWidget {
  const MarsDustPage({super.key});

  @override
  State<MarsDustPage> createState() => _MarsDustPageState();
}

class _MarsDustPageState extends State<MarsDustPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _dustAnimation;

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
      duration: const Duration(seconds: 5),
    );

    _dustAnimation = Tween<double>(begin: begin, end: end).animate(
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

      _dustAnimation = Tween<double>(begin: begin, end: end).animate(
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
    _controller.dispose(); // Dispose the controller!
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mars Dust Storm"),
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
                    "Animation:\nMars Dust Storm",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "🌪️ Red dust moves top ↔ bottom\n\n▶️ Pause/Play: Toggle animation\n↔️ Reverse: Flip dust direction",
                    style: TextStyle(fontSize: 16, color: Colors.white70),
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
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedBuilder(
                          animation: _dustAnimation,
                          builder: (context, child) {
                            final dustPosition = _dustAnimation.value;

                            return Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [dustPosition, dustPosition + 0.1],
                                  colors: [
                                    Colors.red.withOpacity(0.8),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        // Mars Image
                        ClipOval(
                          child: Image.asset(
                            "assets/mars.jpg",
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
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
                        icon: const Icon(Icons.swap_vert),
                        onPressed: reverseDirection,
                        tooltip: "Reverse Dust Direction",
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
