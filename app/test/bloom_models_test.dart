// WARP_PROMPT: Comprehensive tests for BloomProfile and JournalEntry models.
// Test JSON serialization, copyWith, defaults, and edge cases.

import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_bloom/models/bloom_models.dart';

void main() {
  group('JournalEntry', () {
    test('creates entry with all fields', () {
      final timestamp = DateTime(2026, 2, 19, 3, 45);
      final entry = JournalEntry(
        id: '123',
        timestamp: timestamp,
        voiceText: 'I feel grateful today',
        insight: 'Gratitude amplifies inner peace',
      );

      expect(entry.id, '123');
      expect(entry.timestamp, timestamp);
      expect(entry.voiceText, 'I feel grateful today');
      expect(entry.insight, 'Gratitude amplifies inner peace');
    });

    test('serializes to JSON correctly', () {
      final timestamp = DateTime(2026, 2, 19, 3, 45);
      final entry = JournalEntry(
        id: '123',
        timestamp: timestamp,
        voiceText: 'Test voice',
        insight: 'Test insight',
      );

      final json = entry.toJson();

      expect(json['id'], '123');
      expect(json['timestamp'], timestamp.toIso8601String());
      expect(json['voiceText'], 'Test voice');
      expect(json['insight'], 'Test insight');
    });

    test('deserializes from JSON correctly', () {
      final json = {
        'id': '456',
        'timestamp': '2026-02-19T03:45:00.000',
        'voiceText': 'JSON voice',
        'insight': 'JSON insight',
      };

      final entry = JournalEntry.fromJson(json);

      expect(entry.id, '456');
      expect(entry.timestamp, DateTime(2026, 2, 19, 3, 45));
      expect(entry.voiceText, 'JSON voice');
      expect(entry.insight, 'JSON insight');
    });

    test('round-trip serialization preserves data', () {
      final original = JournalEntry(
        id: '789',
        timestamp: DateTime.now(),
        voiceText: 'Original text',
        insight: 'Original insight',
      );

      final json = original.toJson();
      final restored = JournalEntry.fromJson(json);

      expect(restored.id, original.id);
      expect(restored.timestamp.toIso8601String(), original.timestamp.toIso8601String());
      expect(restored.voiceText, original.voiceText);
      expect(restored.insight, original.insight);
    });
  });

  group('BloomProfile', () {
    test('creates profile with defaults', () {
      final profile = BloomProfile(name: 'TestBloom');

      expect(profile.name, 'TestBloom');
      expect(profile.energy, 0.6);
      expect(profile.journal, isEmpty);
      expect(profile.globalContributions, 0);
    });

    test('creates profile with custom values', () {
      final entry = JournalEntry(
        id: '1',
        timestamp: DateTime.now(),
        voiceText: 'Test',
        insight: 'Insight',
      );

      final profile = BloomProfile(
        name: 'CustomBloom',
        energy: 0.8,
        journal: [entry],
        globalContributions: 5,
      );

      expect(profile.name, 'CustomBloom');
      expect(profile.energy, 0.8);
      expect(profile.journal.length, 1);
      expect(profile.globalContributions, 5);
    });

    test('copyWith updates only specified fields', () {
      final original = BloomProfile(
        name: 'Original',
        energy: 0.5,
        globalContributions: 3,
      );

      final updated = original.copyWith(name: 'Updated');

      expect(updated.name, 'Updated');
      expect(updated.energy, 0.5); // unchanged
      expect(updated.globalContributions, 3); // unchanged
    });

    test('copyWith can update energy', () {
      final profile = BloomProfile(name: 'Test');
      final updated = profile.copyWith(energy: 0.95);

      expect(updated.energy, 0.95);
      expect(updated.name, 'Test'); // unchanged
    });

    test('copyWith can update journal', () {
      final profile = BloomProfile(name: 'Test');
      final entry = JournalEntry(
        id: '1',
        timestamp: DateTime.now(),
        voiceText: 'New entry',
        insight: 'New insight',
      );

      final updated = profile.copyWith(journal: [entry]);

      expect(updated.journal.length, 1);
      expect(updated.journal.first.voiceText, 'New entry');
    });

    test('serializes to JSON correctly', () {
      final entry = JournalEntry(
        id: '1',
        timestamp: DateTime(2026, 2, 19),
        voiceText: 'Voice',
        insight: 'Insight',
      );

      final profile = BloomProfile(
        name: 'JSONBloom',
        energy: 0.75,
        journal: [entry],
        globalContributions: 10,
      );

      final json = profile.toJson();

      expect(json['name'], 'JSONBloom');
      expect(json['energy'], 0.75);
      expect(json['globalContributions'], 10);
      expect(json['journal'], isA<List>());
      expect((json['journal'] as List).length, 1);
    });

    test('deserializes from JSON with defaults', () {
      final json = {'name': 'MinimalBloom'};

      final profile = BloomProfile.fromJson(json);

      expect(profile.name, 'MinimalBloom');
      expect(profile.energy, 0.6);
      expect(profile.journal, isEmpty);
      expect(profile.globalContributions, 0);
    });

    test('deserializes from JSON with all fields', () {
      final json = {
        'name': 'FullBloom',
        'energy': 0.9,
        'journal': [
          {
            'id': '1',
            'timestamp': '2026-02-19T00:00:00.000',
            'voiceText': 'Test',
            'insight': 'Test insight',
          }
        ],
        'globalContributions': 25,
      };

      final profile = BloomProfile.fromJson(json);

      expect(profile.name, 'FullBloom');
      expect(profile.energy, 0.9);
      expect(profile.journal.length, 1);
      expect(profile.globalContributions, 25);
    });

    test('round-trip serialization preserves complete profile', () {
      final entry1 = JournalEntry(
        id: '1',
        timestamp: DateTime(2026, 2, 19, 1, 0),
        voiceText: 'First',
        insight: 'First insight',
      );
      final entry2 = JournalEntry(
        id: '2',
        timestamp: DateTime(2026, 2, 19, 2, 0),
        voiceText: 'Second',
        insight: 'Second insight',
      );

      final original = BloomProfile(
        name: 'RoundTrip',
        energy: 0.85,
        journal: [entry1, entry2],
        globalContributions: 42,
      );

      final json = original.toJson();
      final restored = BloomProfile.fromJson(json);

      expect(restored.name, original.name);
      expect(restored.energy, original.energy);
      expect(restored.journal.length, original.journal.length);
      expect(restored.globalContributions, original.globalContributions);
      expect(restored.journal[0].voiceText, entry1.voiceText);
      expect(restored.journal[1].insight, entry2.insight);
    });

    test('handles empty journal in JSON', () {
      final json = {
        'name': 'EmptyJournal',
        'energy': 0.6,
        'journal': [],
        'globalContributions': 0,
      };

      final profile = BloomProfile.fromJson(json);

      expect(profile.journal, isEmpty);
    });
  });
}
