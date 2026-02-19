import 'package:flutter/material.dart';
import '../services/federation_coordinator.dart';

class FederationHubScreen extends StatefulWidget {
  static const route = '/federation';
  const FederationHubScreen({super.key});

  @override
  State<FederationHubScreen> createState() => _FederationHubScreenState();
}

class _FederationHubScreenState extends State<FederationHubScreen> {
  final _coord = LocalFederationCoordinator();
  Map<String, double>? _model;
  bool _loading = false;

  Future<void> _refresh() async {
    setState(() => _loading = true);
    try {
      final m = await _coord.downloadLatestModel();
      setState(() => _model = m);
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _uploadSample() async {
    await _coord.uploadDelta({'layer1': 0.1, 'layer2': 0.2});
    await _refresh();
  }

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Federation Hub')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Global impact (dev mock):', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(colors: [Colors.teal, Colors.indigo]),
                ),
                child: Center(
                  child: _loading
                      ? const CircularProgressIndicator()
                      : Text(_model?.toString() ?? '{}', style: const TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton.icon(onPressed: _refresh, icon: const Icon(Icons.refresh), label: const Text('Refresh')),
                const SizedBox(width: 8),
                ElevatedButton.icon(onPressed: _uploadSample, icon: const Icon(Icons.upload), label: const Text('Upload sample delta')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
