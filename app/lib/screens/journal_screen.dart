import 'package:flutter/material.dart';
import '../services/bloom_ai.dart';
import '../services/storage_provider.dart';

class JournalScreen extends StatefulWidget {
  static const route = '/journal';
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final _controller = TextEditingController();
  final _ai = BloomAI();
  final _store = LocalStorageProvider();
  bool _busy = false;
  String? _lastInsight;

  Future<void> _weave() async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await _ai.init();
      final text = _controller.text.trim();
      final insight = await _ai.generateInsight(text.isEmpty ? '...' : text);
      await _store.saveBloomData({
        'ts': DateTime.now().toIso8601String(),
        'input': text,
        'insight': insight,
      });
      setState(() => _lastInsight = insight);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Saved: $insight')),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Journal')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText: 'Speak or type your thoughts... (voice coming soon)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.mic),
                  label: const Text('Speak'),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: _busy ? null : _weave,
                  icon: _busy ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.send),
                  label: const Text('Weave'),
                ),
              ],
            ),
            if (_lastInsight != null) ...[
              const SizedBox(height: 12),
              Text(_lastInsight!, style: const TextStyle(color: Colors.white70)),
            ],
          ],
        ),
      ),
    );
  }
}
