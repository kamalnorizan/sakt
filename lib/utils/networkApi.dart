import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkApi {
  String baseUrl = "https://sakt.kncircle.com/api/";
  String path;
  final Map<String, String>? defaultHeaders;
  final Duration timeout;

  NetworkApi({
    required this.path,
    this.defaultHeaders,
    this.timeout = const Duration(seconds: 30),
  });

  Map<String, String> _buildHeaders(Map<String, String>? headers) {
    final Map<String, String> mergedHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (defaultHeaders != null) {
      mergedHeaders.addAll(defaultHeaders!);
    }

    if (headers != null) {
      mergedHeaders.addAll(headers);
    }

    return mergedHeaders;
  }

  String _buildUrl(String endpoint) {
    if (endpoint.startsWith('http')) {
      return endpoint;
    }

    return '$baseUrl$endpoint';
  }

  Future<dynamic> post(
    String endpoint, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    final url = _buildUrl(endpoint);
    final uri = Uri.parse(url);

    final response = await http
        .post(uri, headers: _buildHeaders(headers), body: jsonEncode(body))
        .timeout(timeout);

    return response;
  }

  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    final url = _buildUrl(endpoint);
    final uri = Uri.parse(url);

    final response = await http
        .get(uri, headers: _buildHeaders(headers))
        .timeout(timeout);

    return response;
  }
}
