import 'package:flutter/material.dart';

class VenusPage extends StatefulWidget {
  const VenusPage({super.key});

  @override
  State<VenusPage> createState() => _VenusPageState();
}

class _VenusPageState extends State<VenusPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool isAnimating = true;
  bool isReversed = false;

  double begin = -0.2;
  double end = 1.2;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
  }

  void _setupAnimation() {
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.repeat();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void togglePlayPause() {
    setState(() {
      if (isAnimating) {
        _controller.stop();
      } else {
        _controller.forward();
      }
      isAnimating = !isAnimating;
    });
  }

  void reverseDirection() {
    setState(() {
      // Swap begin and end
      final oldBegin = begin;
      begin = end;
      end = oldBegin;

      // Rebuild animation with same controller
      _animation = Tween<double>(begin: begin, end: end).animate(
        CurvedAnimation(parent: _controller, curve: Curves.linear),
      );

      // Restart the controller from the current position in new direction
      _controller.reset();
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Illuminating Venus",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.brown,
      ),
      backgroundColor: Colors.grey[900],
      body: Row(
        children: [
          // Left side - Info panel
          Flexible(
            flex: 1,
            child: Container(
              color: Colors.brown[300],
              padding: const EdgeInsets.all(20),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Animation:\nIlluminating Planet",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 9),
                  Text(
                    "💡 A beam of light moves across the planet's surface.\n"
                    "Tap the control buttons below the planet to interact.",
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
          // Right side - Animation
          Flexible(
            flex: 2,
            child: Container(
              color: Colors.black,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return CustomPaint(
                          painter: LightPainter(_animation.value),
                        );
                      },
                    ),
                  ),
                  Center(
                    child: ClipOval(
                      child: Image.asset(
                        "assets/venus.jpg",
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Control buttons
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          icon: const Icon(Icons.swap_horiz),
                          onPressed: reverseDirection,
                          tooltip: "Reverse Direction",
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

class LightPainter extends CustomPainter {
  final double position;

  LightPainter(this.position);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.yellow.withOpacity(0.8),
          Colors.transparent,
        ],
        stops: [0.0, 1.0],
      ).createShader(Rect.fromCircle(
        center: Offset(size.width * position, size.height / 2),
        radius: 150,
      ));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant LightPainter oldDelegate) {
    return oldDelegate.position != position;
  }
}
