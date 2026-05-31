import 'package:flutter/material.dart';

class ThemeBackground extends StatelessWidget {
  final Widget child;
  final int themeIndex;

  const ThemeBackground({
    Key? key,
    required this.child,
    this.themeIndex = 0,
  }) : super(key: key);

  static const List<List<Color>> gradients = [
    [Color(0xFF3A7BD5), Color(0xFF3A6073)], // Cool Blue
    [Color(0xFFFF5F6D), Color(0xFFFFC371)], // Peach sunset
    [Color(0xFF11998E), Color(0xFF38EF7D)], // Neon green
    [Color(0xFF8A2387), Color(0xFFE94057), Color(0xFFF27121)], // Warm sunset
    [Color(0xFF1F1C2C), Color(0xFF928DAB)], // Midnight dark
  ];

  @override
  Widget build(BuildContext context) {
    final colors = gradients[themeIndex % gradients.length];
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(child: child),
    );
  }
}
