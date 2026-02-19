import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

class BloomOrbGame extends FlameGame {
  BloomOrbGame({required this.energy});

  double energy; // 0..1
  late CircleComponent _core;
  late TimerComponent _emitterTimer;

  @override
  Future<void> onLoad() async {
    final sizeMin = math.min(size.x, size.y);

    // Core pulsing orb
    _core = CircleComponent(
      radius: sizeMin * 0.18,
      anchor: Anchor.center,
      position: size / 2,
      paint: Paint()
        ..shader = const RadialGradient(
          colors: [Color(0xFF00E5FF), Color(0xFF1A237E)],
          stops: [0.0, 1.0],
        ).createShader(Rect.fromCircle(center: Offset(size.x / 2, size.y / 2), radius: sizeMin * 0.22)),
    );
    add(_core);

    // Gentle pulse
    _core.add(ScaleEffect.to(
      Vector2.all(1.06 + 0.06 * energy),
      EffectController(duration: 2.4, reverseDuration: 2.4, infinite: true, curve: Curves.easeInOut),
    ));

    // Particle emitter (glow + tendrils). Rate reacts to energy.
    _scheduleEmitter();
  }

  void _scheduleEmitter() {
    _emitterTimer = TimerComponent(period: _periodFromEnergy(), repeat: true, onTick: _emitOnce);
    add(_emitterTimer);
  }

  double _periodFromEnergy() => 0.12 + (1.0 - energy) * 0.35; // faster with higher energy

  void setEnergy(double v) {
    energy = v.clamp(0.0, 1.0);
    // Adjust emission rate
    _emitterTimer.timer.stop();
    _emitterTimer.timer.limit = _periodFromEnergy();
    _emitterTimer.timer.start();
  }

  void _emitOnce() {
    final center = size / 2;
    final rnd = math.Random();
    final baseColor = Color.lerp(const Color(0xFF1A237E), const Color(0xFF00E676), energy)!;

    // Burst of tiny glowing dots drifting outward
    add(ParticleSystemComponent(
      position: center,
      particle: Particle.generate(
        lifespan: 1.8 + rnd.nextDouble() * 0.8,
        count: 24 + (energy * 22).round(),
        generator: (i) {
          final angle = rnd.nextDouble() * math.pi * 2;
          final speed = 20 + rnd.nextDouble() * 40 * (0.5 + energy);
          final vx = math.cos(angle) * speed;
          final vy = math.sin(angle) * speed;
          final color = baseColor.withAlpha((140 + 100 * rnd.nextDouble()).round());
          return AcceleratedParticle(
            acceleration: Vector2(-vx, -vy) * 0.05,
            speed: Vector2(vx, vy),
            child: CircleParticle(radius: 1.6 + rnd.nextDouble() * 1.2, paint: Paint()..color = color, lifespan: 1.2),
          );
        },
      ),
    ));
  }
}

class BloomOrbFlame extends StatefulWidget {
  const BloomOrbFlame({super.key, this.size = 200, required this.energy});
  final double size;
  final double energy; // 0..1

  @override
  State<BloomOrbFlame> createState() => _BloomOrbFlameState();
}

class _BloomOrbFlameState extends State<BloomOrbFlame> {
  late final BloomOrbGame _game = BloomOrbGame(energy: widget.energy);

  @override
  void didUpdateWidget(covariant BloomOrbFlame oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.energy != widget.energy) {
      _game.setEnergy(widget.energy);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: GameWidget(game: _game),
    );
  }
}
