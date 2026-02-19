import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../widgets/pulsing_orb.dart';
import '../widgets/simple_bloom_game.dart';
import 'journal_screen.dart';
import 'federation_hub_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  static const route = '/home';
  final LinearGradient gradient;
  const HomeScreen({super.key, required this.gradient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NexusBloom')),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Mesmerizing gradient backdrop
          DecoratedBox(decoration: BoxDecoration(gradient: gradient)),
          // Flame overlay (subtle particles)
          GameWidget(game: SimpleBloomGame()),
          // Content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const PulsingOrb(size: 180),
                const SizedBox(height: 16),
                const Text('Tap for insights', style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 24),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => Navigator.pushNamed(context, JournalScreen.route),
                      icon: const Icon(Icons.mic), label: const Text('Journal'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => Navigator.pushNamed(context, FederationHubScreen.route),
                      icon: const Icon(Icons.public), label: const Text('Federation Hub'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => Navigator.pushNamed(context, SettingsScreen.route),
                      icon: const Icon(Icons.settings), label: const Text('Settings'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
