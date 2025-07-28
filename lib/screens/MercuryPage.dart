import 'package:flutter/material.dart';

class MercuryShrinkPage extends StatefulWidget {
  const MercuryShrinkPage({super.key});

  @override
  State<MercuryShrinkPage> createState() => _MercuryShrinkPageState();
}

class _MercuryShrinkPageState extends State<MercuryShrinkPage> {
  bool _shrunk = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shrinking Mercury"),
        backgroundColor: Colors.brown,
      ),
      backgroundColor: Colors.grey[900],
      body: Row(
        children: [
          // Left Description Panel
          Flexible(
            flex: 1,
            child: Container(
              color: Colors.brown[300],
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Animation:\nShrinking Planet",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "🪐 Mercury shrinks and grows when tapped.\n\n"
                    " Tap the planet to toggle size.\n",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
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
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _shrunk = !_shrunk;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 2),
                    curve: Curves.easeInOut,
                    width: _shrunk ? 100 : 300,
                    height: _shrunk ? 100 : 300,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.brown,
                          blurRadius: 20,
                          spreadRadius: 5,
                          offset: Offset(0, 0),
                        )
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/mercury.jpg",
                        fit: BoxFit.cover,
                      ),
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
