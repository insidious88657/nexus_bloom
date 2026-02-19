import 'dart:math';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class SimpleBloomGame extends Game {
  final _rand = Random();
  final List<_Dot> _dots = [];
  late final Paint _paint;

  @override
  Future<void> onLoad() async {
    _paint = Paint()
      ..color = const Color.fromRGBO(255, 255, 255, 0.06)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    for (var i = 0; i < 30; i++) {
      _dots.add(_Dot(_rand.nextDouble(), _rand.nextDouble()));
    }
  }

  @override
  void render(Canvas canvas) {
    final w = size.x;
    final h = size.y;
    for (final d in _dots) {
      final pos = Offset(d.x * w, d.y * h);
      canvas.drawCircle(pos, 2.5, _paint);
    }
  }

  @override
  void update(double dt) {
    for (final d in _dots) {
      d.t += dt;
      d.x += 0.02 * sin(d.t) * dt;
      d.y += 0.02 * cos(d.t * 1.2) * dt;
      d.x %= 1.0;
      d.y %= 1.0;
    }
  }
}

class _Dot {
  double x, y, t;
  _Dot(this.x, this.y) : t = 0;
}
