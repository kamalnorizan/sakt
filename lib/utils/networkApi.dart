import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class NetworkApi {
  final String baseUrl;
  final Map<String, String>? defaultHeaders;
  final Duration timeout;

  NetworkApi({
    required this.baseUrl,
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
    return baseUrl.endsWith('/') || endpoint.startsWith('/')
        ? '$baseUrl$endpoint'
        : '$baseUrl/$endpoint';
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return null;
      }
      try {
        return json.decode(response.body);
      } catch (e) {
        return response.body;
      }
    } else {
      throw NetworkException(
        statusCode: response.statusCode,
        message: response.body,
      );
    }
  }

  Future<dynamic> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final url = _buildUrl(endpoint);
      final uri = Uri.parse(url).replace(queryParameters: queryParameters);

      final response = await http
          .get(uri, headers: _buildHeaders(headers))
          .timeout(timeout);

      return _handleResponse(response);
    } on SocketException {
      throw NetworkException(statusCode: 0, message: 'No internet connection');
    } on TimeoutException {
      throw NetworkException(statusCode: 0, message: 'Request timeout');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(
    String endpoint, {
    Map<String, String>? headers,
    dynamic body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final url = _buildUrl(endpoint);
      final uri = Uri.parse(url).replace(queryParameters: queryParameters);

      final response = await http
          .post(
            uri,
            headers: _buildHeaders(headers),
            body: body != null ? json.encode(body) : null,
          )
          .timeout(timeout);

      return _handleResponse(response);
    } on SocketException {
      throw NetworkException(statusCode: 0, message: 'No internet connection');
    } on TimeoutException {
      throw NetworkException(statusCode: 0, message: 'Request timeout');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> put(
    String endpoint, {
    Map<String, String>? headers,
    dynamic body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final url = _buildUrl(endpoint);
      final uri = Uri.parse(url).replace(queryParameters: queryParameters);

      final response = await http
          .put(
            uri,
            headers: _buildHeaders(headers),
            body: body != null ? json.encode(body) : null,
          )
          .timeout(timeout);

      return _handleResponse(response);
    } on SocketException {
      throw NetworkException(statusCode: 0, message: 'No internet connection');
    } on TimeoutException {
      throw NetworkException(statusCode: 0, message: 'Request timeout');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> patch(
    String endpoint, {
    Map<String, String>? headers,
    dynamic body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final url = _buildUrl(endpoint);
      final uri = Uri.parse(url).replace(queryParameters: queryParameters);

      final response = await http
          .patch(
            uri,
            headers: _buildHeaders(headers),
            body: body != null ? json.encode(body) : null,
          )
          .timeout(timeout);

      return _handleResponse(response);
    } on SocketException {
      throw NetworkException(statusCode: 0, message: 'No internet connection');
    } on TimeoutException {
      throw NetworkException(statusCode: 0, message: 'Request timeout');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete(
    String endpoint, {
    Map<String, String>? headers,
    dynamic body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final url = _buildUrl(endpoint);
      final uri = Uri.parse(url).replace(queryParameters: queryParameters);

      final response = await http
          .delete(
            uri,
            headers: _buildHeaders(headers),
            body: body != null ? json.encode(body) : null,
          )
          .timeout(timeout);

      return _handleResponse(response);
    } on SocketException {
      throw NetworkException(statusCode: 0, message: 'No internet connection');
    } on TimeoutException {
      throw NetworkException(statusCode: 0, message: 'Request timeout');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> uploadFile(
    String endpoint,
    String filePath,
    String fileFieldName, {
    Map<String, String>? headers,
    Map<String, String>? fields,
  }) async {
    try {
      final url = _buildUrl(endpoint);
      final uri = Uri.parse(url);

      final request = http.MultipartRequest('POST', uri);

      // Add headers
      if (defaultHeaders != null) {
        request.headers.addAll(defaultHeaders!);
      }
      if (headers != null) {
        request.headers.addAll(headers);
      }

      // Add file
      final file = await http.MultipartFile.fromPath(fileFieldName, filePath);
      request.files.add(file);

      // Add fields
      if (fields != null) {
        request.fields.addAll(fields);
      }

      final streamedResponse = await request.send().timeout(timeout);
      final response = await http.Response.fromStream(streamedResponse);

      return _handleResponse(response);
    } on SocketException {
      throw NetworkException(statusCode: 0, message: 'No internet connection');
    } on TimeoutException {
      throw NetworkException(statusCode: 0, message: 'Request timeout');
    } catch (e) {
      rethrow;
    }
  }
}

class NetworkException implements Exception {
  final int statusCode;
  final String message;

  NetworkException({required this.statusCode, required this.message});

  @override
  String toString() => 'NetworkException: $statusCode - $message';
}
