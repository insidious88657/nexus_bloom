import 'dart:math' as math;
import 'package:flutter/material.dart';

class PulsingOrb extends StatefulWidget {
  final double size;
  const PulsingOrb({super.key, this.size = 160});

  @override
  State<PulsingOrb> createState() => _PulsingOrbState();
}

class _PulsingOrbState extends State<PulsingOrb> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (context, _) {
        final s = widget.size * (0.95 + 0.1 * math.sin(_c.value * math.pi * 2));
        return Container(
          width: s,
          height: s,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Colors.tealAccent, blurRadius: 30, spreadRadius: 4),
              BoxShadow(color: Colors.indigoAccent, blurRadius: 60, spreadRadius: -10),
            ],
            gradient: RadialGradient(colors: [Colors.tealAccent, Colors.indigo], radius: 0.85),
          ),
        );
      },
    );
  }
}
