// WARP_PROMPT: Abstract FederationCoordinator. Methods: uploadDelta(Map<String, double>), downloadLatestModel().

import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class FederationCoordinator {
  Future<void> uploadDelta(Map<String, double> delta);
  Future<Map<String, double>> downloadLatestModel();
}

/// Local implementation that talks to the local Node server.
/// The base URL is read from --dart-define=SERVER_URL if provided,
/// otherwise defaults to http://localhost:3000
class LocalFederationCoordinator implements FederationCoordinator {
  final String baseUrl;
  final http.Client _client;

  LocalFederationCoordinator({
    String? baseUrl,
    http.Client? client,
  })  : baseUrl = baseUrl ?? const String.fromEnvironment('SERVER_URL', defaultValue: 'http://localhost:3000'),
        _client = client ?? http.Client();

  Uri _u(String path) => Uri.parse('$baseUrl$path');

  @override
  Future<void> uploadDelta(Map<String, double> delta) async {
    final resp = await _client.post(
      _u('/upload-delta'),
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode({'delta': delta}),
    );
    if (resp.statusCode < 200 || resp.statusCode >= 300) {
      throw Exception('uploadDelta failed: HTTP ${resp.statusCode} ${resp.body}');
    }
  }

  @override
  Future<Map<String, double>> downloadLatestModel() async {
    final resp = await _client.get(_u('/latest-model'));
    if (resp.statusCode != 200) {
      throw Exception('downloadLatestModel failed: HTTP ${resp.statusCode}');
    }
    final decoded = jsonDecode(resp.body);
    if (decoded is! Map) {
      throw Exception('Invalid model payload');
    }
    final model = decoded['model'];
    if (model is! Map) {
      throw Exception('Invalid model field in payload');
    }
    final result = <String, double>{};
    model.forEach((k, v) {
      if (v is num) {
        result[k.toString()] = v.toDouble();
      }
    });
    return result;
  }
}
