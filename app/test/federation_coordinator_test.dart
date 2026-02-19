import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:nexus_bloom/services/federation_coordinator.dart';

void main() {
  test('uploadDelta succeeds on 200', () async {
    final mock = MockClient((request) async {
      expect(request.url.toString(), 'http://localhost:3000/upload-delta');
      expect(request.method, 'POST');
      final body = jsonDecode(request.body) as Map<String, dynamic>;
      expect(body['delta'], isA<Map<String, dynamic>>());
      return http.Response('{"message":"Delta received"}', 200);
    });

    final coord = LocalFederationCoordinator(client: mock);
    await coord.uploadDelta({'layer1': 0.5});
  });

  test('downloadLatestModel parses doubles from {model, version}', () async {
    final mock = MockClient((request) async {
      expect(request.url.toString(), 'http://localhost:3000/latest-model');
      expect(request.method, 'GET');
      return http.Response('{"model":{"layer1":0.8,"layer2":2},"version":5}', 200);
    });

    final coord = LocalFederationCoordinator(client: mock);
    final model = await coord.downloadLatestModel();
    expect(model, {'layer1': 0.8, 'layer2': 2.0});
  });
}
