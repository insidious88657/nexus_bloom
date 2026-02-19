import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_bloom/services/storage_provider.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class FakePathProvider extends PathProviderPlatform {
  final String docs;
  FakePathProvider(this.docs);
  @override
  Future<String?> getApplicationDocumentsPath() async => docs;
}

void main() {
  setUpAll(() {
    // Initialize sqflite for pure-Dart tests
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    // Point path_provider to a temp directory
    final tmp = Directory.systemTemp.createTempSync('bloom_test');
    PathProviderPlatform.instance = FakePathProvider(tmp.path);
  });

  test('LocalStorageProvider can persist and load data', () async {
    final provider = LocalStorageProvider();
    await provider.clear();
    await provider.saveBloomData({'foo': 'bar', 'n': 42});
    final data = await provider.loadBloomData();
    expect(data, isA<Map<String, dynamic>>());
    expect(data!['foo'], 'bar');
    expect(data['n'], 42);
  });
}
