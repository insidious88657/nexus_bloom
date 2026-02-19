// WARP_PROMPT: Core data models for BloomProfile with journal entries, energy, name.
// Immutable models with copyWith, toJson, fromJson for persistence.

class BloomProfile {
  final String name;
  final double energy;
  final List<JournalEntry> journal;
  final int globalContributions;

  BloomProfile({
    required this.name,
    this.energy = 0.6,
    this.journal = const [],
    this.globalContributions = 0,
  });

  BloomProfile copyWith({
    String? name,
    double? energy,
    List<JournalEntry>? journal,
    int? globalContributions,
  }) {
    return BloomProfile(
      name: name ?? this.name,
      energy: energy ?? this.energy,
      journal: journal ?? this.journal,
      globalContributions: globalContributions ?? this.globalContributions,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'energy': energy,
        'journal': journal.map((e) => e.toJson()).toList(),
        'globalContributions': globalContributions,
      };

  factory BloomProfile.fromJson(Map<String, dynamic> json) => BloomProfile(
        name: json['name'] as String,
        energy: (json['energy'] as num?)?.toDouble() ?? 0.6,
        journal: (json['journal'] as List<dynamic>?)
                ?.map((e) => JournalEntry.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        globalContributions: (json['globalContributions'] as int?) ?? 0,
      );
}

class JournalEntry {
  final String id;
  final DateTime timestamp;
  final String voiceText;
  final String insight;

  JournalEntry({
    required this.id,
    required this.timestamp,
    required this.voiceText,
    required this.insight,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'timestamp': timestamp.toIso8601String(),
        'voiceText': voiceText,
        'insight': insight,
      };

  factory JournalEntry.fromJson(Map<String, dynamic> json) => JournalEntry(
        id: json['id'] as String,
        timestamp: DateTime.parse(json['timestamp'] as String),
        voiceText: json['voiceText'] as String,
        insight: json['insight'] as String,
      );
}
