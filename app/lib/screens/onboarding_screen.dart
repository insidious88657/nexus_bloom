import 'package:flutter/material.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatelessWidget {
  static const route = '/onboarding';
  final LinearGradient gradient;
  const OnboardingScreen({super.key, required this.gradient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text('NexusBloom')),
      body: DecoratedBox(
        decoration: BoxDecoration(gradient: gradient),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Birth your Bloom', style: TextStyle(fontSize: 28, color: Colors.white)),
              const SizedBox(height: 12),
              const Text('Voice-guided seedling emergence (coming soon)', style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, HomeScreen.route),
                child: const Text('Begin'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
