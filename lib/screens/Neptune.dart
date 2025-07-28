import 'package:flutter/material.dart';

class NeptunePage extends StatefulWidget {
  const NeptunePage({super.key});

  @override
  State<NeptunePage> createState() => _NeptunePageState();
}

class _NeptunePageState extends State<NeptunePage>
    with TickerProviderStateMixin {
  // Controllers
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;

  // Animations
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  bool isAnimating = true;
  bool isReversed = false;

  double begin1 = 0.1, end1 = 0.8;
  double begin2 = 0.2, end2 = 0.9;
  double begin3 = 0.0, end3 = 0.7;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _controller1.repeat();
    _controller2.repeat();
    _controller3.repeat();
  }

  void _setupAnimations() {
    _controller1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _controller3 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _animation1 = Tween<double>(begin: begin1, end: end1).animate(
      CurvedAnimation(parent: _controller1, curve: Curves.easeInOut),
    );
    _animation2 = Tween<double>(begin: begin2, end: end2).animate(
      CurvedAnimation(parent: _controller2, curve: Curves.easeInOut),
    );
    _animation3 = Tween<double>(begin: begin3, end: end3).animate(
      CurvedAnimation(parent: _controller3, curve: Curves.easeInOut),
    );
  }

  void togglePlayPause() {
    setState(() {
      if (isAnimating) {
        _controller1.stop();
        _controller2.stop();
        _controller3.stop();
      } else {
        _controller1.repeat();
        _controller2.repeat();
        _controller3.repeat();
      }
      isAnimating = !isAnimating;
    });
  }

  void reverseDirection() {
    setState(() {
      isReversed = !isReversed;

      // Swap direction of tweens
      final old1 = begin1;
      begin1 = end1;
      end1 = old1;

      final old2 = begin2;
      begin2 = end2;
      end2 = old2;

      final old3 = begin3;
      begin3 = end3;
      end3 = old3;

      // Rebuild tweens
      _animation1 = Tween<double>(begin: begin1, end: end1).animate(
        CurvedAnimation(parent: _controller1, curve: Curves.easeInOut),
      );
      _animation2 = Tween<double>(begin: begin2, end: end2).animate(
        CurvedAnimation(parent: _controller2, curve: Curves.easeInOut),
      );
      _animation3 = Tween<double>(begin: begin3, end: end3).animate(
        CurvedAnimation(parent: _controller3, curve: Curves.easeInOut),
      );

      // Restart if playing
      _controller1.reset();
      _controller2.reset();
      _controller3.reset();

      if (isAnimating) {
        _controller1.repeat();
        _controller2.repeat();
        _controller3.repeat();
      }
    });
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  Widget buildVolcano(
      Animation<double> animation, double maxHeight, Color color) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final height = animation.value * maxHeight;
        return Container(
          width: 20,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                color,
                Colors.transparent,
              ],
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Neptune's Ice Volcanoes"),
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: Colors.grey[900],
      body: Row(
        children: [
          // Left Description
          Flexible(
            flex: 1,
            child: Container(
              color: Colors.indigo[300],
              padding: const EdgeInsets.all(16),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Animation:\nReverse Ice Eruptions",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "🌋 Ice plumes erupt up and down\n\n▶️ Pause/Play: Freeze or resume\n↔️ Reverse: Flip eruption direction",
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          // Right Animation
          Flexible(
            flex: 2,
            child: Container(
              color: Colors.black,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Neptune background
                  Image.asset(
                    "assets/neptune.jpg",
                    width: 600,
                    height: 320,
                    fit: BoxFit.cover,
                  ),
                  // Volcano plumes
                  Positioned(
                    bottom: 0,
                    child: Row(
                      children: [
                        const SizedBox(width: 80),
                        buildVolcano(_animation1, 100, Colors.cyan),
                        const SizedBox(width: 80),
                        buildVolcano(_animation2, 120, Colors.blue),
                        const SizedBox(width: 80),
                        buildVolcano(_animation3, 80, Colors.lightBlueAccent),
                        const SizedBox(width: 80),
                      ],
                    ),
                  ),
                  // Control buttons
                  Positioned(
                    bottom: 20,
                    child: Row(
                      children: [
                        IconButton(
                          iconSize: 36,
                          icon: Icon(
                              isAnimating ? Icons.pause : Icons.play_arrow),
                          onPressed: togglePlayPause,
                          tooltip: isAnimating ? "Pause" : "Play",
                        ),
                        const SizedBox(width: 30),
                        IconButton(
                          iconSize: 36,
                          icon: const Icon(Icons.swap_vert),
                          onPressed: reverseDirection,
                          tooltip: "Reverse Eruption",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
