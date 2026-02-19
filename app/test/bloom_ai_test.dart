import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_bloom/services/bloom_ai.dart';
import 'package:nexus_bloom/services/federation_coordinator.dart';

class _FakeCoordinator implements FederationCoordinator {
  Map<String, double>? last;
  @override
  Future<Map<String, double>> downloadLatestModel() async => last ?? {};
  @override
  Future<void> uploadDelta(Map<String, double> delta) async {
    last = Map.of(delta);
  }
}

void main() {
  test('BloomAI init + generateInsight returns string', () async {
    final ai = BloomAI(coordinator: _FakeCoordinator());
    await ai.init(); // Should not throw even if model is a placeholder
    final s = await ai.generateInsight('hello world');
    expect(s.startsWith('Insight:'), isTrue);
  });

  test('BloomAI federate sends delta via coordinator', () async {
    final fake = _FakeCoordinator();
    final ai = BloomAI(coordinator: fake);
    await ai.federate();
    expect(fake.last, isNotNull);
    expect(fake.last!.containsKey('param1'), isTrue);
  });
}
