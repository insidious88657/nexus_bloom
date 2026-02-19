import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_bloom/services/storage_provider.dart';

void main() {
  test('LocalStorageProvider stubs are callable', () async {
    final provider = LocalStorageProvider();
    await provider.saveBloomData({'foo': 'bar'});
    final data = await provider.loadBloomData();
    expect(data, anyOf(isNull, isA<Map<String, dynamic>>()));
  });
}
