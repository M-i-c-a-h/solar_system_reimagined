import 'package:flutter/material.dart';

class SampleRoute extends StatefulWidget {
  const SampleRoute({super.key});

  @override
  State<SampleRoute> createState() => _SampleRouteState();
}

class _SampleRouteState extends State<SampleRoute> {
  bool _expanded = false;

  void _toggleSize() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Black Hole Collapse"),
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Colors.grey[900],
      body: Row(
        children: [
          // Left Description Panel with scroll support
          Flexible(
            flex: 1,
            child: Container(
              color: Colors.deepPurple[300],
              padding: const EdgeInsets.all(24),
              child: const SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Animation:\nBlack Hole Collapse",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "🕳️ Tap the black hole to trigger collapse or expansion.\n\n"
                      "An extra page if you didn't like one",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "🔄 Each tap toggles the current state.\n",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Right Animation Area
          Flexible(
            flex: 2,
            child: Container(
              color: Colors.black,
              child: Center(
                child: GestureDetector(
                  onTap: _toggleSize,
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 2),
                    curve: Curves.easeInOutCubic,
                    width: _expanded ? 300 : 100,
                    height: _expanded ? 300 : 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.black,
                          Colors.deepPurple.shade900,
                        ],
                        center: Alignment.center,
                        radius: 0.8,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.deepPurpleAccent,
                          blurRadius: 30,
                          spreadRadius: 10,
                          offset: Offset(0, 0),
                        ),
                      ],
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
