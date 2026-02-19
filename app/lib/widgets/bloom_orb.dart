// WARP_PROMPT: Advanced Flame 1.18 BloomOrb - bioluminescent pulsing orb with particle tendrils.
// Particles: cyan→indigo→purple gradient, accelerated outward, subtle rotation and glow.
// Reacts to an 'energy' double from Riverpod bloomProvider.

import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/bloom_providers.dart';

class BloomOrbWidget extends ConsumerStatefulWidget {
  const BloomOrbWidget({super.key, this.size = 280});
  final double size;

  @override
  ConsumerState<BloomOrbWidget> createState() => _BloomOrbWidgetState();
}

class _BloomOrbWidgetState extends ConsumerState<BloomOrbWidget> {
  late final _game = _BloomGame();

  @override
  Widget build(BuildContext context) {
    final asyncProfile = ref.watch(bloomProvider);
    // Update energy on every build (game handles timing internally)
    asyncProfile.whenData((profile) => _game.updateEnergy(profile.energy));

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: GameWidget(game: _game),
    );
  }
}

class _BloomGame extends FlameGame {
  _BloomGame();

  double energy = 0.5; // 0..1
  CircleComponent? _core;
  CircleComponent? _glow;
  TimerComponent? _emitterTimer;
  bool _loaded = false;

  @override
  Future<void> onLoad() async {
    final sizeMin = math.min(size.x, size.y);
    final center = size / 2;

    // Outer soft glow using blur
    final baseColor = _colorForEnergy(energy);
    _glow = CircleComponent(
      radius: sizeMin * 0.42,
      anchor: Anchor.center,
      position: center,
      paint: Paint()
        ..color = baseColor.withAlpha(35)
        ..maskFilter = const ui.MaskFilter.blur(ui.BlurStyle.normal, 16),
    );
    add(_glow!);

    // Core orb with radial gradient and slow rotation
    _core = CircleComponent(
      radius: sizeMin * 0.28,
      anchor: Anchor.center,
      position: center,
      paint: Paint()
        ..shader = const RadialGradient(
          colors: [Color(0xFF00E5FF), Color(0xFF1A237E), Color(0xFF9C27B0)],
          stops: [0.0, 0.6, 1.0],
        ).createShader(Rect.fromCircle(center: Offset.zero, radius: 1.0)),
    )..angle = 0;
    add(_core!);
    _core!.add(RotateEffect.by(2 * math.pi, EffectController(duration: 30, infinite: true)));

    // Breathing pulse
    _core!.add(ScaleEffect.to(
      Vector2.all(1.06 + 0.06 * energy),
      EffectController(duration: 2.4, reverseDuration: 2.4, infinite: true, curve: Curves.easeInOut),
    ));

    // Particle emission
    _scheduleEmitter();
    _loaded = true;
  }

  void _scheduleEmitter() {
    _emitterTimer?.removeFromParent();
    _emitterTimer = TimerComponent(period: _periodFromEnergy(), repeat: true, onTick: _emitBurst);
    add(_emitterTimer!);
  }

  double _periodFromEnergy() => 0.12 + (1.0 - energy) * 0.35; // faster when energized

  void updateEnergy(double v) {
    energy = v.clamp(0.0, 1.0);
    if (_loaded && _glow != null) {
      _glow!.paint.color = _colorForEnergy(energy).withAlpha(35);
      _scheduleEmitter();
    }
  }

  Color _colorForEnergy(double e) {
    // Interpolate cyan -> indigo -> purple
    const c1 = Color(0xFF00E5FF);
    const c2 = Color(0xFF1A237E);
    const c3 = Color(0xFF9C27B0);
    if (e < 0.5) {
      final t = e / 0.5;
      return Color.lerp(c1, c2, t) ?? c2;
    } else {
      final t = (e - 0.5) / 0.5;
      return Color.lerp(c2, c3, t) ?? c3;
    }
  }

  void _emitBurst() {
    final center = size / 2;
    final rnd = math.Random();
    final baseColor = _colorForEnergy(energy);
    final count = 18 + (energy * 28).round();

    add(ParticleSystemComponent(
      position: center,
      particle: Particle.generate(
        count: count,
        lifespan: 1.8 + rnd.nextDouble() * 0.9,
        generator: (i) {
          final angle = rnd.nextDouble() * math.pi * 2;
          final speed = 24 + rnd.nextDouble() * 48 * (0.6 + energy);
          final vx = math.cos(angle) * speed;
          final vy = math.sin(angle) * speed;
          final c = baseColor.withAlpha((110 + 120 * rnd.nextDouble()).round());
          return AcceleratedParticle(
            acceleration: Vector2(-vx, -vy) * 0.05, // curve inwards slightly
            speed: Vector2(vx, vy),
            child: CircleParticle(
              radius: 1.4 + rnd.nextDouble() * 1.6,
              paint: Paint()..color = c,
              lifespan: 1.2 + rnd.nextDouble() * 0.6,
            ),
          );
        },
      ),
    ));
  }
}
