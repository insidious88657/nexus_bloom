// WARP_PROMPT: Expand BloomNotifier with name, full journal list, load/save via LocalStorageProvider on init & changes. Use async notifier.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/bloom_models.dart';
import '../services/storage_provider.dart';

class BloomNotifier extends AsyncNotifier<BloomProfile> {
  final _storage = LocalStorageProvider();

  @override
  Future<BloomProfile> build() async {
    final loaded = await _storage.loadBloomProfile();
    return loaded ?? BloomProfile(name: 'Unnamed Bloom');
  }

  Future<void> setName(String name) async {
    final current = state.value;
    if (current == null) return;
    final newState = current.copyWith(name: name);
    state = AsyncData(newState);
    await _storage.saveBloomProfile(newState);
  }

  Future<void> addJournalEntry(JournalEntry entry) async {
    final current = state.value;
    if (current == null) return;
    final newJournal = [...current.journal, entry];
    final newState = current.copyWith(
      journal: newJournal,
      energy: (current.energy + 0.1).clamp(0.0, 1.0),
    );
    state = AsyncData(newState);
    await _storage.saveBloomProfile(newState);
  }

  void updateEnergy(double delta) {
    final current = state.value;
    if (current == null) return;
    final newEnergy = (current.energy + delta).clamp(0.0, 1.0);
    state = AsyncData(current.copyWith(energy: newEnergy));
  }

  void setInsight(String insight) {
    // For backwards compatibility - store as energy bump
    updateEnergy(0.1);
  }

  void incrementContributions() {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(current.copyWith(
      globalContributions: current.globalContributions + 1,
    ));
  }

  String get lastInsight {
    final current = state.value;
    if (current == null || current.journal.isEmpty) return 'Awakening...';
    return current.journal.last.insight;
  }
}

final bloomProvider = AsyncNotifierProvider<BloomNotifier, BloomProfile>(
  () => BloomNotifier(),
);
