import 'package:flutter/material.dart';
import 'MercuryPage.dart';
import 'samplePage.dart';
import 'VenusPage.dart';
import 'EarthPage.dart';
import 'MarsPage.dart';
import 'JupiterPage.dart';
import 'SaturnPage.dart';
import 'Uranus.dart';
import 'Neptune.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<String> planets = [
    "Mercury",
    "Venus",
    "Earth",
    "Mars",
    "Jupiter",
    "Saturn",
    "Uranus",
    "Neptune",
    "Black Hole"
  ];

  final Map<String, Widget> planetRoutes = {
    "Mercury": MercuryShrinkPage(),
    "Venus": VenusPage(),
    "Earth": EarthOrbitPage(),
    "Mars": MarsDustPage(),
    "Jupiter": JupiterPulsePage(),
    "Saturn": SaturnPage(),
    "Uranus": UranusPage(),
    "Neptune": NeptunePage(),
    "Black Hole": SampleRoute(),
  };

  final Map<String, CurveTween> planetTransitions = {
    "Mercury": CurveTween(curve: Curves.bounceIn),
    "Venus": CurveTween(curve: Curves.easeInCubic),
    "Earth": CurveTween(curve: Curves.elasticOut),
    "Mars": CurveTween(curve: Curves.fastOutSlowIn),
    "Jupiter": CurveTween(curve: Curves.decelerate),
    "Saturn": CurveTween(curve: Curves.easeInQuad),
    "Uranus": CurveTween(curve: Curves.easeOutExpo),
    "Neptune": CurveTween(curve: Curves.easeInOutQuart),
    "Black Hole": CurveTween(curve: Curves.easeInCirc),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Solar System Reimagined",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.brown,
      ),
      backgroundColor: Colors.grey[900],
      body: ListView.builder(
        itemCount: planets.length,
        itemBuilder: (context, index) {
          final planet = planets[index];
          final routeWidget = planetRoutes[planet];
          final curveTween = planetTransitions[planet]; // Fixed

          return buildPlanetCard(context, planet, routeWidget, curveTween);
        },
      ),
    );
  }

  Widget buildPlanetCard(
    BuildContext context,
    String planet,
    Widget? routeWidget,
    CurveTween? curveTween,
  ) {
    return GestureDetector(
      onTap: () {
        if (routeWidget != null) {
          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                routeWidget,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final curvedAnimation =
                  curveTween?.animate(animation) ?? animation;
              return SlideTransition(
                position: Tween(begin: const Offset(0.0, 1.0), end: Offset.zero)
                    .animate(curvedAnimation),
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 2000),
          ));
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SampleRoute()),
          );
        }
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: Colors.brown[300],
        child: Container(
          height: 120,
          alignment: Alignment.center,
          child: Text(
            planet,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
