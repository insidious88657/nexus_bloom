// WARP_PROMPT: Riverpod 2026 setup - create providers for Bloom energy, last insight, federation stats. Use StateNotifier for mutability.

import 'package:flutter_riverpod/flutter_riverpod.dart';

class BloomState {
  final double energy;        // 0.0 - 1.0 (drives orb pulse)
  final String lastInsight;
  final int globalContributions;

  BloomState({this.energy = 0.6, this.lastInsight = "Awakening...", this.globalContributions = 0});

  BloomState copyWith({double? energy, String? lastInsight, int? globalContributions}) {
    return BloomState(
      energy: energy ?? this.energy,
      lastInsight: lastInsight ?? this.lastInsight,
      globalContributions: globalContributions ?? this.globalContributions,
    );
  }
}

class BloomNotifier extends StateNotifier<BloomState> {
  BloomNotifier() : super(BloomState());

  void updateEnergy(double newEnergy) => state = state.copyWith(energy: newEnergy.clamp(0.0, 1.0));
  void setInsight(String insight) => state = state.copyWith(lastInsight: insight);
  void incrementContributions() => state = state.copyWith(globalContributions: state.globalContributions + 1);
}

final bloomProvider = StateNotifierProvider<BloomNotifier, BloomState>((ref) => BloomNotifier());
