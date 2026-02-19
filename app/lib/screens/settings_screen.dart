import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  static const route = '/settings';
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with SingleTickerProviderStateMixin {
  bool privacy = true;
  bool analytics = false;
  late final AnimationController _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _AnimatedToggle(
            title: 'Private by default',
            value: privacy,
            onChanged: (v) => setState(() => privacy = v),
          ),
          const SizedBox(height: 12),
          _AnimatedToggle(
            title: 'Share anonymized insights',
            value: analytics,
            onChanged: (v) => setState(() => analytics = v),
          ),
        ],
      ),
    );
  }
}

class _AnimatedToggle extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _AnimatedToggle({required this.title, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title, style: const TextStyle(fontSize: 16))),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(colors: value ? [Colors.greenAccent, Colors.teal] : [Colors.grey.shade700, Colors.grey.shade600]),
          ),
          child: Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            inactiveThumbColor: Colors.white70,
          ),
        )
      ],
    );
  }
}
