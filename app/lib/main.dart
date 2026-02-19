// WARP_PROMPT: Basic Flutter app setup with Riverpod, MaterialApp, custom theme with organic gradients and animations.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/home_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/journal_screen.dart';
import 'screens/federation_hub_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(const ProviderScope(child: NexusBloomApp()));
}

class NexusBloomApp extends StatelessWidget {
  const NexusBloomApp({super.key});

  @override
  Widget build(BuildContext context) {
    const gradient = LinearGradient(
      colors: [Color(0xFF00C853), Color(0xFF1A237E)], // emerald -> indigo
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return MaterialApp(
      title: 'NexusBloom',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00C853)),
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          headlineMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, foregroundColor: Colors.white, centerTitle: true, elevation: 0),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.route,
      routes: {
        OnboardingScreen.route: (_) => const OnboardingScreen(gradient: gradient),
        HomeScreen.route: (_) => const HomeScreen(),
        JournalScreen.route: (_) => const JournalScreen(),
        FederationHubScreen.route: (_) => const FederationHubScreen(),
        SettingsScreen.route: (_) => const SettingsScreen(),
      },
    );
  }
}
