// WARP_PROMPT: HomeScreen with BloomOrb center, voice journal FAB, federation button, insight card.
// Dark cosmic theme with soft glows. Riverpod-driven.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../widgets/bloom_orb.dart';
import '../providers/bloom_providers.dart';
import '../services/bloom_ai.dart';
import '../models/bloom_models.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const route = '/home';
  const HomeScreen({super.key});
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final BloomAI _ai = BloomAI();

  @override
  void initState() {
    super.initState();
    _ai.init();
  }

  Future<void> _startVoiceJournal() async {
    final available = await _speech.initialize();
    if (available) {
      await _speech.listen(
        onResult: (result) async {
          if (result.finalResult) {
            final insight = await _ai.generateInsight(result.recognizedWords);
            final entry = JournalEntry(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              timestamp: DateTime.now(),
              voiceText: result.recognizedWords,
              insight: insight,
            );
            await ref.read(bloomProvider.notifier).addJournalEntry(entry);
          }
        },
      );
    }
  }

  Future<void> _testFederation() async {
    await _ai.federate();
    ref.read(bloomProvider.notifier).incrementContributions();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Δ contributed to Humanity Bloom')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncProfile = ref.watch(bloomProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0A1F3A), Color(0xFF1E3A5F), Color(0xFF2C5A8C)],
          ),
        ),
        child: SafeArea(
          child: asyncProfile.when(
            data: (profile) => Column(
              children: [
                const SizedBox(height: 40),
                Text(
                  profile.name,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.cyanAccent),
                ),
                const SizedBox(height: 20),
                const BloomOrbWidget(),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    color: Colors.black.withValues(alpha: 0.4),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        profile.journal.isEmpty
                            ? 'Speak to your Bloom to weave your first insight...'
                            : profile.journal.last.insight,
                        style: const TextStyle(fontSize: 18, color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  'Helped ${profile.globalContributions}k humans today',
                  style: const TextStyle(color: Colors.cyan),
                ),
                const SizedBox(height: 20),
              ],
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.red))),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: _startVoiceJournal,
            backgroundColor: Colors.cyanAccent,
            tooltip: 'Speak to your Bloom',
            child: const Icon(Icons.mic, size: 32),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            onPressed: _testFederation,
            backgroundColor: Colors.indigoAccent,
            tooltip: 'Contribute to Humanity',
            child: const Icon(Icons.public),
          ),
        ],
      ),
    );
  }
}
