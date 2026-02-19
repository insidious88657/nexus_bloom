// WARP_PROMPT: Create a custom widget using Flame for a pulsing, bioluminescent orb that animates
// based on a 'health' double (0-1). Include haptic feedback.

import 'dart:ui' as ui;
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BloomOrb extends StatelessWidget {
  final double health; // 0..1
  final double size;
  const BloomOrb({super.key, required this.health, this.size = 200});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        HapticFeedback.lightImpact();
      },
      child: SizedBox(
        width: size,
        height: size,
        child: GameWidget(game: _BloomGame(health: health, logicalSize: size)),
      ),
    );
  }
}

class _BloomGame extends FlameGame {
  final double health; // 0..1
  final double logicalSize;
  _BloomGame({required this.health, required this.logicalSize});

  late final CircleComponent _core;
  late final CircleComponent _glow;

  @override
  Future<void> onLoad() async {
    // Use dynamic canvas size; components position themselves using logicalSize

    // Color shifts from indigo (low) to emerald (high)
    final color = Color.lerp(const Color(0xFF1A237E), const Color(0xFF00C853), health) ?? Colors.green;

    // Outer glow, very soft and blurred
    _glow = CircleComponent(
      radius: logicalSize * (0.48 + 0.1 * health),
      anchor: Anchor.center,
      position: Vector2.all(logicalSize / 2),
      paint: Paint()
        ..color = color.withAlpha((0.15 * 255).round())
        ..maskFilter = const ui.MaskFilter.blur(ui.BlurStyle.normal, 12),
    );
    add(_glow);

    // Core orb with radial gradient via shader
    _core = _GradientCircle(
      radius: logicalSize * (0.34 + 0.08 * health),
      centerPos: Vector2.all(logicalSize / 2),
      inner: color.withAlpha((0.95 * 255).round()),
      outer: const Color(0xFF0D0D0D),
    );
    add(_core);

    // Gentle pulse that scales with health
    final scaleMin = 0.92 + 0.02 * health;
    final scaleMax = 1.06 + 0.06 * health;
    _core.add(ScaleEffect.to(
      Vector2.all(scaleMax),
      EffectController(duration: 2.4, reverseDuration: 2.4, infinite: true, curve: Curves.easeInOut),
      onComplete: () {},
    ));
    _core.add(ScaleEffect.to(
      Vector2.all(scaleMin),
      EffectController(startDelay: 2.4, duration: 2.4, reverseDuration: 0, infinite: true, curve: Curves.easeInOut),
    ));
  }
}

class _GradientCircle extends CircleComponent {
  final Vector2 centerPos;
  final Color inner;
  final Color outer;

  _GradientCircle({required double radius, required this.centerPos, required this.inner, required this.outer})
      : super(radius: radius, anchor: Anchor.center, position: centerPos);

  @override
  void render(Canvas canvas) {
    // Radial gradient shader for bioluminescent core
    final shader = ui.Gradient.radial(
      Offset(centerPos.x, centerPos.y),
      radius,
      [inner, outer],
      [0.0, 1.0],
    );
    final p = Paint()
      ..shader = shader
      ..blendMode = BlendMode.plus;

    canvas.drawCircle(Offset(centerPos.x, centerPos.y), radius, p);
  }
}
